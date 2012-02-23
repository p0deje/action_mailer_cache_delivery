## Description

Enhances ActionMailer to support the `:cache` delivery method, which behaves like `:test`, except that the deliveries are marshalled to a temporary cache file, thus making them available to other processes.

You'll want to use this gem if you're testing with Selenium (or any other tool which distinct processes).

## Installation

Add to Gemfile

```ruby
gem 'action_mailer_cache_delivery'
```

Now run `bundle install`

## Usage

Change delivery method in your `config/environments/test.rb`

```ruby
config.action_mailer.delivery_method = :cache
```

You can optionally specify location for cache file.

```ruby
config.action_mailer.cache_settings = { :location => "#{Rails.root}/tmp/mail.cache" }
```

To access the cached deliveries in another process, just do

```ruby
ActionMailer::Base.cached_deliveries
```

## Use with parallel_tests

If you use [parallel_tests](https://github.com/grosser/parallel_tests "parallel_tests") to run your tests in parallel, you may get unexpected errors like `EOFError`. If so, make sure cache files differ for processes. Change you `config/environment/test.rb`

```ruby
config.action_mailer.cache_settings = { :location => "#{Rails.root}/tmp/cache/action_mailer_cache_delivery#{ENV['TEST_ENV_NUMBER']}.cache" }
```

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
