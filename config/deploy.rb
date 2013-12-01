require 'bundler/capistrano' # for bundler support
# require 'rvm/capistrano'
require 'sidekiq/capistrano'

set(:sidekiq_cmd) { "bundle exec sidekiq" }
set(:sidekiqctl_cmd) { "bundle exec sidekiqctl" }
set(:sidekiq_timeout) { 10 }
set(:sidekiq_role) { :app }
set(:sidekiq_pid) { "#{current_path}/tmp/pids/sidekiq.pid" }
set(:sidekiq_processes) { 1 }


set :application, "membio" # This should mirror what you put in your NGinx Conf

set :user, 'logan' # Whatever the User You Make on Your Server

set :repository,  "git@github.com:loganhasson/membio.git" # The address of your fork's clone URL

set :branch, "master"

set :deploy_to, "/home/#{ user }/#{ application }"
set :use_sudo, false

set :scm, :git

default_run_options[:pty] = true

set :rvm_type, :system

set :server_ip, '162.243.247.233' # This should be your server IP
role :web, "#{server_ip}"                          # Your HTTP server, Apache/etc
role :app, "#{server_ip}"                          # This may be the same as your `Web` server
role :db,  "#{server_ip}", :primary => true        # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
before "deploy:restart", "deploy:symlink_database", "deploy:symlink_api_credentials"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :symlink_database, :roles => :app do
    # run "ln -nfs #{shared_path}/production.sqlite3 #{current_path}/db/production.sqlite3"
  end

  task :symlink_api_credentials, :roles => :app do
    # run "ln -nfs #{shared_path}/application.yml #{current_path}/config/application.yml"
    # run "ln -nfs #{shared_path}/faye_token.rb #{current_path}/config/initializers/faye_token.rb"
  end

  task :migrate, :roles => :app do 
    run "cd #{current_path} && rake db:migrate RACK_ENV=production"
  end
 
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :bootstrap do
    run "cd #{release_path}; RAILS_ENV=production rake db:migrate"
    # run "cd #{release_path}; RAILS_ENV=production ./script/delayed_job restart"
    # uncomment if you run BigTuna in BigTuna so that it gets build automatically
    # you will need to set up valid hook name in project config
    # run "curl --request POST --silent http://bigtuna.your.site/hooks/build/bigtuna"
  end
end


after "deploy:finalize_update", "deploy:symlink_database"
before "deploy:restart", "deploy:bootstrap"