# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'seller_leads'
set :repo_url, 'git@github.com:ankitmoveinc/test-r5.git'
set :deploy_to, '/opt/railssvc/rdc-next'
set :ruby_version, '2.3.0'
set :user, 'railssvc'
set :rvm_type, :system
set :rvm_ruby_version, "#{fetch(:ruby_version)}@#{fetch(:application)}"
set :passenger_pid_file, "--pid-file #{fetch(:deploy_to)}/shared/pids/passenger.pid"
set :passenger_log_file, "--log-file #{fetch(:deploy_to)}/shared/logs/passenger.log"
set :keep_releases, 3

namespace :deploy do

  desc "Run bundle install"
  task :run_bundle_install do
    on roles(:all) do
      within current_path do
        execute :bundle, 'install --local'
      end
    end
  end
end
