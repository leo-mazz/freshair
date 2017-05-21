# config valid only for current version of Capistrano
lock "3.8.1"

set :application, "FreshAir.org.uk"
set :repo_url, "git@bitbucket.org:freshair/refresh-website.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :deploy_to, "/var/www/refresh-website"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/secrets.yml", "config/application.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5


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
