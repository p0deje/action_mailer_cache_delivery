$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require 'action_mailer_cache_delivery/version'

Gem::Specification.new do |gem|
  gem.name     = 'action_mailer_cache_delivery'
  gem.homepage = 'https://github.com/p0deje/action_mailer_cache_delivery'
  gem.version  = ActionMailerCacheDelivery::VERSION
  gem.license  = 'MIT'

  gem.authors = 'Alex Rodionov'
  gem.email   = 'p0deje@gmail.com'

  gem.summary     = 'Cache delivery method for ActionMailer'
  gem.description = 'Cache delivery method for ActionMailer for testing emails with Selenium'

  gem.files       = `git ls-files`.split("\n")
  gem.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  gem.add_dependency 'actionmailer', '>= 3.0'

  gem.add_development_dependency 'rspec' , '~> 2.8'
  gem.add_development_dependency 'rake'  , '~> 0.9'
end
