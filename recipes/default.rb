#
# Cookbook Name:: dotfiles
# Recipe:: default
#
# Copyright 2012, Oversun-Scalaxy LTD
#

# Required for backuping original files
require 'fileutils'

# Installing required git core-packages
package 'git-core' do
	action :install
	options '--force-yes'
end

# Retrieving admins collection
admins = data_bag("admins")
# logging debug_info
log "[dotfiles] 1. #{admins}" do
	level :debug
end

# admins list round-trip
admins.each do |login|
	admin = data_bag_item("admins", login)
	home = "/home/#{login}"
	
	#logging debug info
	log "[dotfiles] 2. #{admin} #{home}" do
		level :debug
	end
	
	#logging debug info
	log "[dotfiles] 3. #{admin['dotfiles']['enabled']}" do
		level :debug
	end
	
	# Exporting files only if user realy wants to
	if admin['dotfiles']['enabled'] == true 
		# Exporting standard dotfiles only if home_directory exists	
		git "#{home}/.dotfiles" do
			repository node[:dotfiles][:standard_repository]
			action :export
			only_if {File.directory?(home)}
			log "[dotfiles] Uploading standard dotfiles for #{admin} from #{node[:dotfiles][:standard_repository]} to .dotfiles" do
				level :info
			end
		end
		
		Dir.foreach("#{home}/.dotfiles") do |entry|
			backup(entry)
			link "#{home}/#{entry}" do
				to entry
			end
		end
		log "[dotfiles] Default dotfiles successfuly exported from '#{node[:dotfiles][':standard_repository']}'" do
			level :info
		end

		# Uploading all user's custom dotfiles if present
		git "#{home}/.custom_dotfiles" do
			repository admin['dotfiles']['custom_dotfiles_repo']
			user login
			action :sync
			not_if { admin['dotfiles']['custom_dotfiles_repo'].nil? }
			only_if {File.directory?(home)}
		end
		
		admin['dotfiles']['files'].each do |entry|
			backup(entry)
			link "#{home}/#{entry}" do
				to "#{home}/.custom_dotfiles/#{entry}"
			end
		end
	end
end
