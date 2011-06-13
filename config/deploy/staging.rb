set :application, "gamesite"
set :repository,  "git@github.com:mjuneja/gamesite.git"

set :deploy_to, "/home/deploy/web/#{application}"
set :keep_releases, 3

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
set :branch, 'master'
set :user, 'deploy'
set :use_sudo, false
set :rails_env, "staging"
default_run_options[:pty] = true
ssh_options[:forward_agent] = false
set :deploy_via, :remote_cache
set :git_shallow_clone, 1
set :git_enable_submodules, 1

role :app, "173.45.228.20"
role :web, "173.45.228.20"
role :db, "173.45.228.20", :primary => true


namespace :deploy do
 desc "Restarting mod_rails with restart.txt"
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "touch #{current_path}/tmp/restart.txt"
 end

 [:start, :stop].each do |t|
   desc "#{t} task is a no-op with mod_rails"
   task t, :roles => :app do ; end
 end
 
 task :after_symlink, :roles => :app do
   run "cp #{shared_path}/database.yml #{current_path}/config/database.yml"
   run "ln -s #{shared_path}/assets #{current_path}/public/assets"
 end

end