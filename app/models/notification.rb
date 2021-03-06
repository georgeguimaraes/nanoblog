class Notification < ActionMailer::Base

  def new_account(user, sent_at = Time.now)
    subject       'Welcome to Nanoblog'
    recipients    user.email
    from          'nanoblog@nanoblog.com'
    sent_on       sent_at
    content_type  'text/html'
    body          :user => user
  end

end
