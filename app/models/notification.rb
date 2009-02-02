class Notification < ActionMailer::Base
  

  def new_account(sent_at = Time.now)
    subject    'Notification#new_account'
    recipients ''
    from       ''
    sent_on    sent_at
    
    body       :greeting => 'Hi,'
  end

end
