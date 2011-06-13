class GamesUser < ActiveRecord::Base
  belongs_to :game 
  belongs_to :user
  
  validates_presence_of :game_id, :user_id

  validates_uniqueness_of :user_id, :scope => [:game_id, :status],
                                    :message => "The game is already in your list",
                                    :if => Proc.new { |u| u.status != RENTING_STATUS[:subscribed]}
                                 
  after_create :send_notification

  def send_notification
    SubscriberMailer.deliver_grab_notification(user, game) if status==RENTING_STATUS[:grabbed]
  end
  
  def self.grabbed_and_not_rented_records
    all(:conditions => ['status = ? and grabbed_at <= ?' ,RENTING_STATUS[:grabbed],2.days.ago])
  end
  
  def self.notified_but_not_grabbed_records
    all(:conditions => ['status = ? and notified_at <= ?',RENTING_STATUS[:notified],2.days.ago])  
  end
  
 
    
  def self.remove_those_who_grabbed_2days_ago_notify_those_who_shortlisted
   invalid_grabbed_games = grabbed_and_not_rented_records
    invalid_grabbed_games.each{
    |game| SubscriberMailer.deliver_not_rented_notification(game.user, game.game)
    notify_those_who_shortlisted_and_update_status(game)
    remove_record(game.id)
  }
 end

 def self.notify_those_who_shortlisted_and_update_status(shortlisted_game)
    shortlisted_records = GamesUser.all(:conditions => ['status=? and game_id = ?',RENTING_STATUS[:shortlisted],shortlisted_game.game_id])
    unless shortlisted_records.blank?
      shortlisted_records.each{ 
      |sgame| sgame.update_attributes(:status=>RENTING_STATUS[:notified],:notified_at => Time.now)
      SubscriberMailer.deliver_notification_to_shortlisted_users(sgame.user,sgame.game)
    }
    end
 end
 
 #Those who are notified,if none of them  grabbed,need to be deleted from database
 def self.notified_but_not_grabbed
   invalid_shortlisted_games = notified_but_not_grabbed_records
   invalid_shortlisted_games.each{
    |shortlisted_game| SubscriberMailer.deliver_not_grabbed_notification(shortlisted_game.user, shortlisted_game.game) 
    remove_record(shortlisted_game.id)
    }
 end
 
 def self.find_grabbed_games 
   @grabbed_games =  grabbed_and_not_rented_records
  end
  
  def self.notify_users(game)
    @users = GamesUser.all(:conditions => {:game_id => game, :status => RENTING_STATUS[:shortlisted]})
    @users.each do |u|
      u.update_attributes(:status => RENTING_STATUS[:notified], :notified_at => Time.now)
      SubscriberMailer.deliver_notification_to_shortlisted_users(u.user, game)
    end
  end
 
 protected
 
 def self.remove_record(id)
   GamesUser.destroy(id)
 end
    
end

