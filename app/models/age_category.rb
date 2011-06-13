class AgeCategory < ActiveRecord::Base
  has_many :games
  cattr_accessor :per_page
  @@per_page = 10
end
