default['dotfiles'] = {
  :files => [], # Customize per user.
  :standard_repository => Nil, # Don't use.
  :enabled_standard -> false,
  :data_bag => 'users',
  :custom_dotfiles_dir => 'dotfiles',
  :custom_dotfiles_repo_prefix => Nil
}
