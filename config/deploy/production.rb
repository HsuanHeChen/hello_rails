role :app, %w{ubuntu@52.68.172.26}
role :web, %w{ubuntu@52.68.172.26}
role :db,  %w{ubuntu@52.68.172.26}

set :user, 'ubuntu'

set :puma_conf, "#{shared_path}/config/puma/#{fetch(:rails_env, 'development')}.rb"

set :branch, :master
set :rails_env, :production