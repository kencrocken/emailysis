# config/unicorn.rb
# worker_processes 3
# timeout 30
# preload_app true

# before_fork do |server, worker|
#   Signal.trap 'TERM' do
#     puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
#     Process.kill 'QUIT', Process.pid
#   end

#   defined?(ActiveRecord::Base) and
#     ActiveRecord::Base.connection.disconnect!
# end

# after_fork do |server, worker|
#   Signal.trap 'TERM' do
#     puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
#   end

#   defined?(ActiveRecord::Base) and
#     ActiveRecord::Base.establish_connection
# end

worker_processes 3
preload_app true
timeout 30

# setting the below code because of the preload_app true setting above:
# http://unicorn.bogomips.org/Unicorn/Configurator.html#preload_app-method

before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
    Rails.logger.info('Disconnected from ActiveRecord')
  end
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
    Rails.logger.info('Connected to ActiveRecord')
  end
end