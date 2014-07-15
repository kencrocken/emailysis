web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
dj_worker: QUEUES=encode,compress bundle exec rake jobs:work