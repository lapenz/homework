class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@athus.com"
  layout 'mailer'
end
