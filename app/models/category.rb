class Category < ActiveRecord::Base
  has_and_belongs_to_many :games
  cattr_accessor :per_page
  @@per_page = 10
  
  def to_param
      name
  end
  
end
