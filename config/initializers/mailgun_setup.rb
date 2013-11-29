ActionMailer::Base.smtp_settings = {
  :port           => 587,
  :address        => 'smtp.mailgun.org',
  :user_name      => 'postmaster@sandbox214.mailgun.org',
  :password       => ENV["MAILGUN_PASSWORD"],
  :domain         => 'sandbox214.mailgun.org',
  :authentication => :plain,
}

ActionMailer::Base.delivery_method = :smtp