$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require 'action_mailer_cache_delivery/version'

Gem::Specification.new do |s|
  s.name        = 'action_mailer_cache_delivery'
  s.homepage    = 'https://github.com/p0deje/action_mailer_cache_delivery'
  s.version     = ActionMailerCacheDelivery::VERSION

  s.authors     = 'Alex Rodionov'
  s.email       = 'p0deje@gmail.com'

  s.summary     = 'Cache delivery method for ActionMailer'
  s.description = 'Cache delivery method for ActionMailer for testing emails with Selenium'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.add_dependency 'actionmailer', '~> 3.0'

  s.add_development_dependency 'rspec' , '~> 2.8'
  s.add_development_dependency 'rake'  , '~> 0.9'
end
