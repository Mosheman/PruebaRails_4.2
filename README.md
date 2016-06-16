# PruebaRails_4.2

1. Installing MongoDB

First let's install MongoDB from their official repository:

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10

sudo echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" | tee -a /etc/apt/sources.list.d/10gen.list

sudo apt-get -y update

sudo apt-get -y install mongodb-10gen

If you run mongo in your shell you should get an interactive database prompt:

MongoDB shell version: 2.4.6
connecting to: test

2. Install Rails 4

3. $ bundle install
Para cada instrucción, una consola:
4. $ rails s
5. $ redis-server
6. $ bundle exec sidekiq
