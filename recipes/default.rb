#
# Cookbook Name:: dotfiles
# Recipe:: default
#
# Copyright 2012, Oversun-Scalaxy LTD
#

# Required for backuping original files
require 'fileutils'

admins = data_bag("admins")
admins.each do |login|
	admin = data_bag_item("admins", login)
	home = "/home/#{login}"
	
	# Exporting files only if user realy wants to
	unless admin["dotfiles"]["enabled"] and admin["dotfiles"]["enabled"] == true
		# Exporting standard dotfiles only if home_directory exists	
		git "#{home}/.dotfiles" do
			repository :standard_dotfiles
			action :export
			only_if {File.directory?(home)}
		end
		
		Dir.foreach("#{home}/.dotfiles") do |entry|
			backup(entry)
			link "#{home}/#{entry}" do
				to entry
			end
		end

		# Uploading all user's custom dotfiles if present
		git "#{home}/.custom_dotfiles" do
			repository admin["dotfiles"]["custom_dotfiles_repo"]
			user login
			action :sync
			not_if { admin["dotfiles"]["custom_dotfiles_repo"].nil? }
			only_if {File.directory?(home)}
		end
		
		admin["dotfiles"]["files"].each do |entry|
			backup(entry)
			link "#{home}/#{entry}" do
				to "#{home}/.custom_dotfiles/#{entry}"
			end
		end
	end
end
