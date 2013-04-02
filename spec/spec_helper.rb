require 'action_mailer'
require 'action_mailer_cache_delivery'

#
# Simple mailer.
#
class Mailer < ActionMailer::Base
  def test_mail
    mail(from: 'from@test.com', to: 'to@test.com', subject: 'Test email', body: 'Hello.')
  end
end # Mailer
