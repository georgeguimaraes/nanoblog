if defined?(ActionMailer)
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.default_charset = 'utf-8'
  ActionMailer::Base.smtp_settings = {
    :address => 'xxxxxxxxxxxxxxxxxxxxxxx',
    :port => 25,
    :domain => 'xxxxxxxxx',
    :user_name => 'xxxxxx',
    :password => 'xxxxxxxxxxxxxx',
    :authentication => :cram_md5
  }
end
