#
# Cookbook Name:: dotfiles
# Recipe:: default
#
# Copyright 2012, Oversun-Scalaxy LTD
#

# Required for backuping original files

admins = data_bag("admins")

log "[dotfiles] 1. #{admins}" do
	level :info
end

admins.each do |login|
	admin = data_bag_item("admins", login)
	home = "/home/#{login}"


	log "[dotfiles] 2. #{admin} #{home}" do
		level :info
	end
	
	# Exporting files only if user realy wants to
	
	log "[dotfiles] 3. #{admin['dotfiles']['enabled']}" do
		level :info
	end

	if admin['dotfiles']['enabled'] == true 
		# Exporting standard dotfiles only if home_directory exists	
		git "#{home}/.dotfiles" do
			
			log "[dotfiles] 4. #{node[:dotfiles][:standard_repository]}" do
				level :info
			end

			repository node[:dotfiles][:standard_repository]
			action :export
			only_if {File.directory?(home)}
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
