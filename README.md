## membio

membio is an app to make creating and managing to-do lists simple.

### Notes
####To get this to work, you'll need to get a few things set up
* Set up a Twilio account
* Install redis (brew install redis)
* Create an `application.yml` file in `config` and add an APPLICATION_SECRET_KEY_BASE, TWILIO_SID, PRODUCTION_IP, and TWILIO_AUTH_TOKEN to it. For info on correct formatting, check out the figaro gem.
* Create a `faye_token.rb` file in `config/initializers` and add a FAYE_TOKEN to it. (Can be anything you want)

####To get up and running

##### Step 1

```bash
$ bundle
```

##### Step 2

```bash
$ rake db:migrate
```

##### Step 3

```bash
$ redis-server
```

##### Step 4

```bash
$ bundle exec sidekiq
```

##### Step 5

```bash
$ rackup faye.rb -s thin -E production
```

##### Step 6

```bash
$ unicorn -p 3000
```

### Fork away!