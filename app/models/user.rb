require 'digest/sha1'

class User < ActiveRecord::Base
  
  has_many :games_users, :dependent => :destroy
  has_many :shortlisted_games, :through => :games_users, :source => :game, :conditions => ["status = ?", RENTING_STATUS[:shortlisted]]
  has_many :notified_games, :through => :games_users, :source => :game, :conditions => ["status = ?", RENTING_STATUS[:notified]]
  has_one :grabbed_game, :through => :games_users, :source => :game, :conditions => ["status = ?", RENTING_STATUS[:grabbed]]
  has_one :rented_game, :through => :games_users, :source => :game, :conditions => ["status = ?", RENTING_STATUS[:rented]]
  has_many :subscribed_games, :through => :games_users, :source => :game, :conditions => ["status = ?", RENTING_STATUS[:subscribed]]
  has_many :games, :through => :games_users, :uniq => true
  has_many :subscription_renewals
  named_scope :active, :conditions => {:is_active => 1}
  
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  cattr_reader :per_page
  @@per_page = 10
  attr_accessor :old_password
  validates_format_of       :name,     :with => Authentication.name_regex,  
                                     :message => Authentication.bad_name_message, :allow_nil => true
  
  validates_length_of       :name, :maximum => 100
  validates_presence_of     :phone, :name, :email

  validates_format_of       :phone,    :with => /(^9[\d]{9})/, 
                                       :unless =>Proc.new{|i| i.phone.blank?}
  validates_length_of       :email,    :within => 6..100, 
                                       :unless =>Proc.new{|i| i.email.blank?}
  validates_uniqueness_of   :email,    :unless => Proc.new{|i| i.email.blank?}
     
  
  validates_format_of       :email,    :with => Authentication.email_regex, 
                                       :message => Authentication.bad_email_message, 
                                       :unless => Proc.new{|i| i.email.blank?}
  validate_on_create            :check_uniqueness_on_identification_token
               
  after_create              :send_reg_notification

  attr_protected :crypted_password, :salt,:is_active,:subscribed_on
  
  def validate
     if dob and dob > Date.today
       self.errors.add_to_base("You have entered a wrong date of birth")
   end
 end
 
 def check_uniqueness_on_identification_token
   if User.find_by_identification_token(self.identification_token)
     self.identification_token = User.make_identification_token and save
   end
 end
  
  def send_reg_notification
    SubscriberMailer.deliver_signup_notification(self)
  end

  def self.authenticate(email, password)
    return nil if email.blank? || password.blank?
    u = find_by_email(email.downcase) 
    u && u.authenticated?(password) ? u : nil
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  def updated
    self.is_active, self.subscribed_on = true, Date.today
    SubscriptionRenewal.create(:renewed_on => self.subscribed_on, :user => self)
    save(false)
  end
  
  def renewed
    if !subscription_renewals.blank?
      if self.rented_game || Date.today - 30 < self.subscription_renewals.last.renewed_on
        SubscriptionRenewal.create(:renewed_on => self.subscription_renewals.last.renewed_on + 30, :user => self)
      else
        SubscriptionRenewal.create(:renewed_on => Date.today, :user => self)
      end
    end
    self.update_attribute(:is_active, true)
  end
  
  def create_reset_code
    @reset = true
    self.update_attribute(:reset_code, User.make_token)
    SubscriberMailer.deliver_reset_notification(self)
  end
  
  def self.make_identification_token
   (1..10).collect{(("A".."Z").to_a + ("a".."z").to_a + ("0".."9").to_a).rand}.join
  end
  
  def recently_reset?
    @reset
  end
  
  def delete_reset_code
    self.update_attribute(:reset_code, nil) 
  end
  
  def can_grab_game?(game)
    if self.grabbed_game || game.available_for_shortlisting
      return false
    else
      return game
    end
  end
  
  def already_shortlisted(game)
    shortlisted_games.include?(game) 
  end
  
  def remove_shortlisted_game(game_to_delete)
    shortlisted_games.delete(game_to_delete)
  end
  
  def self.send_renew_subscription_notification
    users = User.active
    users.each do |user|
      if !user.subscription_renewals.blank?
        if Date.today > user.subscription_renewals.last.renewed_on+20
          SubscriberMailer.deliver_subscription_notification(user)
        end
      elsif Date.today > user.subscribed_on+20
        SubscriberMailer.deliver_subscription_notification(user)
      end
    end
  end
  
  def self.deactivate_if_subscription_exceeds_one_month
    users = User.active
    users.each do |user|
      if !user.subscription_renewals.blank?
        if Date.today > user.subscription_renewals.last.renewed_on+29
          user.update_attribute(:is_active, 0)
          SubscriberMailer.deliver_subscription_cancelled_notification(user)
        end
      elsif Date.today > user.subscribed_on+29
        user.update_attribute(:is_active, 0)
        SubscriberMailer.deliver_subscription_notification(user)
      end
    end
  end

end