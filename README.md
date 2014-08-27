# Clojure Dev
=========

## This repository includes

* A vagrant file for creating and configuring a virtual Ubuntu Precise machine.
* A set of puppet modules for performing provisioning tasks

## Services Enabled

* installs vim
* installs git
* installs postgresql
* installs sqlite3
* installs Leiningen (which installs clojure)
  - The current version is 2.4.2 (2.4.3 has an issue with repl)

## Applications

My applications are in the gitignore file, and are handled as sub-modules with
their own git repos, so this repository for basic setup can be open source.

## Many Thanks

To the good people of Oracle (Virtualbox), Vagrant, Clojure, Leiningen, vim,
git, postgresql and sqlite3 for all of their contributions.


## Installation

*   fork this repo
*   install Virualbox
*   install Vagrant
*   cd into this directory and vagrant up --provision
*   if you want to make commits from inside the virtual machine, I highly
    recommend uncommenting the git username and name sections and updating them
    with your information.

## First Runs

`vagrant up --provision`

It will probably fail the first time. Fear not - `vagrant ssh` into your machine
and edit `/home/vagrant/.ssh/authorized_keys` and add your github_key_file.pub.
Exit the vm and run `vagrant halt`, then `vagrant up --provision` again

If you get an error that says something about "Failed to mount folders on linux
guest", then `vagrant ssh` back into the machine and run this command

`sudo ln -s /opt/VBoxGuestAdditions-4.3.10/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions`

Exit the vm and run `vagrant provision`. Once the catalog run is done, you can
`vagrant ssh` into your new clojure vm.

