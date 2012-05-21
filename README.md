Dotfiles chef-recipe
====================

But why?
--------

This chef recipe was designed to make administrators everyday routine little bit more comfortable.
Tastes differ, so you never been satisfied with default .${SHELL}rc file, and when you needed to fix some things on
a freshly setup machine REALY fast and efficient, there were none of your favorite bells and whistles like aliases 
or completion options at hand.

Sounds familiar to you? Now it's fixed.

But how?
--------

Recipe just exports your pretty dotfiles (like .bashrc/.zshrc .vimrc ...) on your chef nodes from git repository
then links it to your home directory. 

How to?
-------

You have to make data_bag admins for now to make this recipe to work.
  
  `$ knife data bag create admins`

Then add an admin item to your databag
  
  `$ knife data bag create admins admin_name`
  
  `$ knife data bag edit admins admin_name`
    
  <pre>{
    "id": "admin_name",
    "dotfiles": {
      "comment": "section for dotfiles recipe only",
      "enabled_standard": false,
      "enabled_custom": true,
      "custom_dotfiles": [
        ".zshrc",
        ".vimrc",
        ".toprc"
      ],  
      "custom_dotfiles_repo": "YOUR_PUBLIC_REPOSITORY_HERE"
    }
  }</pre>

Explanation
-----------

There are two sources of dotfiles - *standard* and *custom*
* *Standard* dotfiles assumed to be something like standard in your organization. 
You can change path to *standard repository* only in attributes/default.rb file of this recipe
* *Custom* dotfiles are your additional custom dotfiles you want to have on all your nodes. 
You can change path to *custom repository* in your admin data bag item. 

Data bag attributes
-------------------

* *enabled_standard* - Enables usage of standard repository.
* *enabled_custom* - Enables/disables usage of your custom repository.
* *custom_dotfiles* - Is an array of dotfilenames you want to be linked to your home directory.
* *custom_dotfiles_repo* - Custom dotfiles repo.

