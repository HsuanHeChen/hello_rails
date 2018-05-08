daemonize true
workers 4
#preload_app!
prune_bundler
threads 0, 4

app_path = File.dirname(__FILE__) + "/../../"

bind "unix://#{app_path}tmp/sockets/puma.socket"
state_path "#{app_path}tmp/pids/puma.state"
pidfile "#{app_path}tmp/pids/puma.pid"

rackup      DefaultRackup
environment ENV['RACK_ENV'] || 'production'

# on_worker_boot do
#   ActiveSupport.on_load(:active_record) do
#     ActiveRecord::Base.establish_connection
#   end
# end
