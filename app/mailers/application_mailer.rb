class ApplicationMailer < ActionMailer::Base
  default from: 'proggramingtesttarou@gmail.com'
  # ここを変えないと
  layout 'mailer'
end
