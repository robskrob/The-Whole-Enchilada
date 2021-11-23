class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('INTERNAL_MAILER_FROM', 'info@thewholeenchilada.cc')
  layout 'mailer'
end
