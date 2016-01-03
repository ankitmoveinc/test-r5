# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'seller_leads'
set :repo_url, 'git@github.com:ankitmoveinc/test-r5.git'
#set :user, 'railssvc'
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/opt/railssvc/rdc-next'

set :ruby_version, '2.3.0'
set :user, 'railssvc'
set :rvm_type, :system
set :rvm_ruby_version, "#{fetch(:ruby_version)}@#{fetch(:application)}"
# set :ssh_options, {
#   forward_agent: true,
#   user: fetch(:user),
#   keys: 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAqDk+fj0QpXV1WPkV5OlTuhep70LZjhciYpEdjGqvmaltEenuAj8epyZSJQZqfnwwj4cE8ZvLzJ1sTHKnVsP+PQYAEXB7mLBomG+pum53oforvUEYQkLsMUpxSpqh3frYcR1yyIb+Qm65KCOo9pQbWe43LSkUDfWcYOYKyjvn42z+qBYe2PQ8QjUHS5k2lBmRCEbbjP3dfWBAQMoo4czMxpZWd/O9HKJ6I6vCsR/bYsMWfTqigPY53VhB8zpKMKwcssHt4OLh54GTjdT3B42kvMs8M4A9MGiqMkMeUhN78pr/pTH+GzvV9vDUTP5zVgZfD6XE8tslyhyGKavZCD71JQ== itops-sysadmin@move.com
# ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAw7bA3ylxEkOUYWNCZuJg+HIVPySHo2slrTyOuGnwSlMdZ307eN4hCdMIcH59EI67+848zGPOTzjH0fBXAZa6bW/d6MbLsqZXcE5HqrUE4eSCbqvl8h8mv74ysHmhx/llDEQeWLZ6C/f0S7EaQMxMqqo5jKwGYJyzy/t2jtHREPguh3Q8JoZUmW/90ui/cZ13ZpVJsYoOPRocd4Ua6t1k+GCGDfO0Pigp6apaS96ygPBO7FFNZXZbNosdsnKehZffiRT4Y7zqkpD7Hfj4iY6iJz3CNEXqU6bBUDmN8Gyr7VX1Wqy32pAKK6SCVIsYxvPgFjrQODYpF2YQ2ZjWbj5DgQ=='
# }
# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 3

namespace :deploy do

  desc "Run bundle install"
  task :run_bundle_install do
    on roles(:all) do
      within current_path do
        execute :bundle, 'install --local'
        #execute 'cd /opt/railssvc/rdc-next/current && bundle install --local'
      end
    end
  end

  desc "Hard reset passenger"
  task :hard_reset do
    on roles(:all) do
      execute "sudo /etc/init.d/passenger stop || true && sudo /etc/init.d/passenger start"
    end
  end

  after :published, :run_bundle_install
  after :finished, :hard_reset, :clear_cache
end
