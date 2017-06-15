# config valid only for current version of Capistrano
lock "3.8.1"

set :application, "FreshAir.org.uk"
set :repo_url, "https://leo-mazz:ACCIDENTI1209@bitbucket.org/freshair/refresh-website.git"
set :deploy_to, "/var/www/refresh"

# Default value for :linked_files is []
append :linked_files, "config/application.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "public/uploads", "vendor/bundle"



# The following lines are required because we can't directly access our Virtual
# Machine through ssh. This is because of Tardis' firewall policies
# (made necessary by the University's concerns).
# We then use 'ssh.tardis.ed.ac.uk' as a gateway for deployment.
# You can also override bastion host and bastion user from the command line,
# like this: BASTION_HOST=example.com bundle exec cap production deploy
require 'net/ssh/proxy/command'

# Use a default host for the bastion, but allow it to be overridden
bastion_host = ENV['BASTION_HOST'] || 'ssh.tardis.ed.ac.uk'

# Use the local username by default
bastion_user = ENV['BASTION_USER'] || ENV['USER']

# Configure Capistrano to use the bastion host as a proxy
ssh_command = "ssh #{bastion_user}@#{bastion_host} -W %h:%p"
set :ssh_options, proxy: Net::SSH::Proxy::Command.new(ssh_command)
