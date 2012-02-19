## Description

Currently ActionMailer only supports `:test`, `:smtp`, `:sendmail` and `:file` delivery methods. This gem enhances ActionMailer to support the `:cache` method, which behaves like `:test`, except that the deliveries are marshalled to a temporary cache file, thus making them available to other processes.

## Installation

### Rails 3

Add to Gemfile

    gem 'action_mailer_cache_delivery'

Now run `bundle install`

### Rails 2

    cd RAILS_ROOT
    ./script/plugin install git://github.com/ngty/action_mailer_cache_delivery.git

## Usage

Change ActionMailer delivery method in `:cache` in your `config/environments/test.rb`

    config.action_mailer.delivery_method = :cache

To access the cached deliveries in another process, just do

    ActionMailer::Base.cached_deliveries

## Contributors

I tried to list there everyone who forked original version on GitHub. If you're not here, just send pull request.

* ngty (Ng Tze Yang)
* robinsp (Robin Spainhour)
* thibaudgg (Thibaud Guillaume-Gentil)
* liangzan (Wong Liang Zan)
* railssignals (Kurt Kowar)
* esdras (Esdras Mayrink)
* nicolasochem (Nicolas Ochem)
* reactualize
* ragaskar (Rajan Agaskar)
* marhan (Markus Hanses)
