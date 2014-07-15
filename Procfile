web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
worker: QUEUES=encode,compress bundle exec rake jobs:work