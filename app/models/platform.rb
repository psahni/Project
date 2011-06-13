class Platform < ActiveRecord::Base
  has_many :games
  cattr_accessor :per_page
  @@per_page = 10
  
  def to_param
      name
   end
end
