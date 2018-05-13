# config valid only for current version of Capistrano
lock "3.7.2"

set :application, "hello_rails"
set :repo_url, "git@github.com:HsuanHeChen/hello_rails.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"
# set :deploy_to, "/opt/www/#{fetch(:application)}"
set :deploy_to, "/opt/www/icarry-official-web"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"
set :linked_files, %w{config/database.yml config/secrets.yml config/settings.yml}

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
# config valid only for current version of Capistrano

set :puma_conf, "#{shared_path}/config/puma/#{fetch(:rails_env, 'development')}.rb"
set :puma_workers, 2          # default是0, 此行一定要加
set :puma_preload_app, false  # default是false, 此行可不加
set :puma_prune_bundler, true
set :puma_user, "#{fetch(:user, 'ubuntu')}"

set :keep_releases, 5

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, 'exec', :rake, 'assets:precompile'
        end
      end
      # Your restart mechanism here, for example:
      execute :mkdir, '-p', "#{ release_path }/tmp"
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end
