# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

set :stages, %w(staging production)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

namespace :deploy do
  
  desc "Deploy with migrations"
   task :long do
     transaction do
       update_code
       web.disable
       symlink
       migrate
     end

     restart
     web.enable
     cleanup
   end

   desc "Run cleanup after long_deploy"
   task :after_deploy do
     cleanup
   end
  
end