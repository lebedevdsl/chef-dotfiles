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

SD Defaults
-----------

Our per-user data bag is named `users`. Each engineer has their own data bag.
Include this dotfiles section in a new user's data bag:

    "dotfiles": {
      "enabled_standard": true,
      "enabled_custom": false
    }

This will install the standard
[SpanishDict dotfiles](https://github.com/spanishdict/dotfiles).

This dotfiles section can be customized -- see below.

Editing data bags
------------------

Add a new user item to the users data bag:

  `$ knife data bag create users admin_name`

Edit the users data bag:

  `$ knife data bag edit users admin_name`

  <pre>{
    ...
    "dotfiles": {
      "enabled_standard": false,
      "enabled_custom": true,
      "custom_dotfiles": [
        ".zshrc",
        ".vimrc",
        ".toprc"
      ],
      "custom_dotfiles_repo": "YOUR_PUBLIC_REPOSITORY_HERE",
      "custom_dotfiles_dir": "dir in ~ where dotfiles will be deposited, default ~/.custom_dotfiles",
      "custom_dotfiles_repo_prefix": "optional prefix before dotfiles in repo, default Nil"
    }
  }</pre>

Explanation
-----------

There are two sources of dotfiles - *standard* and *custom*.
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
* *custom_dotfiles_dir* - Directory in your home directory where dotfiles will be deposited, defaults to `~/.custom_dotfiles`.
* *custom_dotfiles_repo_prefix* - optional prefix before dotfile path within repo, defaults to `Nil`.
