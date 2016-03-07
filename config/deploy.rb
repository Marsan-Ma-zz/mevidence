# ref: http://capistranorb.com/documentation/getting-started/preparing-your-application/
set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"") # Read from local

set :application, 'adhug'
set :repo_url, 'git@Mevidence:mevidence'
set :scm, :git

set :format, :pretty
set :log_level, :debug
set :pty, true

set :stage, :production
set :branch, 'master'
set :deploy_to, "/home/marsan/workspace/mevidence"


set :linked_files, %w{config/mongoid.yml config/config.yml}
set :linked_dirs, %w{log public/sitemap}

set :deploy_via, :remote_cache
set :copy_exclude, [".git", ".DS_Store", ".gitignore", ".gitmodules"]

set :user, "marsan"
set :use_sudo, false

set :rvm_type, :user 
set :rvm_ruby_version, '2.1.2@mevidence'

set :default_env, { path: "/opt/ruby/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH" }
set :keep_releases, 5

#-----------------------------------------------------------
#   Tasks
#-----------------------------------------------------------
namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     within release_path do
  #       execute :rake, 'cache:clear'
  #     end
  #   end
  # end

  after :finishing, 'deploy:cleanup'

end
