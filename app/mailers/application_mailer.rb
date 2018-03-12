class ApplicationMailer < ActionMailer::Base
  default from: DEFAULT_SENDER
  layout 'mailer'
end
