# Producerun

# To start app locally

    rake db:create db:migrate db:seed

You will also need to download and run redis server.

   redis-server

# To deploy to heroku

    git remote add heroku git@heroku.com:produceruncatarse.git
    git push heroku

# To run production version locally

    RAILS_ENV=production rake assets:precompile
    rails s -e production -p 3003

# We keep all keys and settings in CatarseSettings. To enable login, key *:base_domain* should point to the url. For example for domain.com

    rails c
    CatarseSettings[:base_domain] = "domain.com"

# To test the code, switch back to :pt in config/initializers/locale.rb

    rake

