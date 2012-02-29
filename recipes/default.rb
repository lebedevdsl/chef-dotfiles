#
# Cookbook Name:: dotfiles
# Recipe:: default
#
# Copyright 2012, Oversun-Scalaxy LTD
#

admins = data_bag("admins")
admins.each do |login|
	admin = data_bag_item("admins", login)
	home = "/home/#{login}"
	
	unless File.directory?(home)
		git "#{home}/.dotfiles" do
			repository :standart_dotfiles
			action :sync
		end

	unless admin["custom_dotfiles_repo"].nil?
		git "#{home}/.custom_dotfiles" do
			repository admin["custom_dotfiles_repo"]
			user login
			action :sync
		end

end
