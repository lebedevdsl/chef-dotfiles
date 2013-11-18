default['dotfiles'] = {
  :files => [".bashrc"], # Customize per user.
  :standard_repository => nil, # Customize per organization.
  :enabled_standard => false, # Customize per organization.
  :data_bag => 'admins', # Customize per organization.
  :custom_dotfiles_dir => '.custom_dotfiles', # Customizer per user.
  :custom_dotfiles_repo_prefix => nil # Customize per user.
}
