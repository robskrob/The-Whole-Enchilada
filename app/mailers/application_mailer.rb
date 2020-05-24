class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('INTERNAL_MAILER_FROM', 'info@thewholeenchilada.com')
  layout 'mailer'
end
