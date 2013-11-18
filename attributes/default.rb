default['dotfiles'] = {
  :files => [".bashrc",".zshrc",".vimrc"],
  :standard_repository => "git://github.com/lebedevdsl/my-dotfiles.git",
  :data_bag => 'admins',
  :custom_dotfiles_dir => '.custom_dotfiles',
  :custom_dotfiles_repo_prefix => Nil
}
