class SubscriberMailer < ActionMailer::Base
  layout 'mailer'
  
  def signup_notification(user)
    setup_email(user)
    @subject ="Registration for gamesite" 
  end
  
  def account_activation(user)
    setup_email(user)
    @subject = "Account activation notification"
  end
  
  def account_deactivation(user)
    setup_email(user)
    @subject = "Account deactivation notification"
  end
  
  def reset_notification(user)
    setup_email(user)
    @subject = "Link to reset your password"
    @body[:url] = "http://ajax4u.com/reset/#{user.reset_code}"
    @body[:user] = user
  end
  
  def grab_notification(user, game)
    setup_email(user)
    @subject = "[gamesite] Grabbed game "+"[#{game.name}]" 
    @body = {:user => user, :game => game}
  end

  def not_rented_notification(user, game)
    setup_email(user)
    @subject = "[gamesite] Rent game "+"[#{game.name}]"
    @body[:game] = game
  end
  
  def notification_to_shortlisted_users(user, game)
    setup_email(user)
    @subject ="[gamesite] Shortlisted game "+"[#{game.name}]"
    @body = {:user => user, :game => game}
  end
 
 def not_grabbed_notification(user, game)
   setup_email(user)  
   @subject = "[gamesite] Grab game "+"[#{game.name}]"
   @body[:game] = game
 end
 
 def subscription_notification(user)
   setup_email(user)
   @subject = "Your subscription is about to expire."
 end
 
 def subscription_cancelled_notification(user)
   setup_email(user)
   @subject = "Your subscription has been cancelled."
 end
 
 def send_user_mail(user, message)
   @recipients = user.email
   @sent_on = Time.now
   @body = message
   @user = user
   @subject = "[gamesite] Admin has sent you a message"
   @from = "admin@gamesonrent.in"
   @content_type = 'text/html'
 end
 
 def setup_email(user)
   @recipients = user.email
   @sent_on = Time.now
   @body = {:user => user}
   @from = "admin@gamesonrent.in"
   @content_type = 'text/html'
  end
  
end
