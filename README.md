# PruebaRails_4.2

* Install Rails 4.2.1

* Installing MongoDB
First let's install MongoDB from their official repository:

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
sudo echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" | tee -a /etc/apt/sources.list.d/10gen.list
sudo apt-get -y update
sudo apt-get -y install mongodb-10gen

If you run mongo in your shell you should get an interactive database prompt:

MongoDB shell version: 2.4.6
connecting to: test

* Rails 4 with Mongoid
Next you're going to need to generate your Rails application with rails new myapp --skip-active-record. The --skip-active-record is important because it doesn't include ActiveRecord in the app that is generated. We need to modify the Gemfile to remove sqlite3 and add Mongoid.

You'll want to delete these lines from your Gemfile:

# Use sqlite3 as the database for Active Record
gem 'sqlite3'
And add these:

gem 'mongoid', '~> 4', github: 'mongoid/mongoid'
gem 'bson_ext'

* Do "bundle install"

The mongoid gem that supports Rails 4 hasn't been fully published yet so we're using it directly from their Github repository. Now that these are added you can run bundle to install the gems for your Rails app.

Now we need to generate the Mongoid configuration file that is very much like your config/database.yml that you may be used to with ActiveRecord. We'll create the mongoid file by running the following command:

rails g mongoid:config
This generates config/mongoid.yml which you can take a look at and make any configuration changes as necessary.