class Game < ActiveRecord::Base
  
  belongs_to :platform
  belongs_to :age_category
  has_and_belongs_to_many :categories,  :join_table => 'categories_games'
  has_many :games_users, :dependent => :destroy
  has_many :users_who_shortlisted, :through => :games_users, :source => :user, :conditions => ["status = ?", RENTING_STATUS[:shortlisted]]
  has_many :users_who_grabbed, :through => :games_users, :source => :user, :conditions => ["status = ?", RENTING_STATUS[:grabbed]]
  has_many :notified_users, :through => :games_users, :source => :user, :conditions => ["status = ?", RENTING_STATUS[:notified]] 
  has_many :users_who_rented, :through => :games_users, :source => :user, :conditions => ["status = ?", RENTING_STATUS[:rented]]
  has_many :subscribed_users, :through => :games_users, :source => :user, :conditions => ["status = ?", RENTING_STATUS[:subscribed]]  
  has_many :users, :through => :games_users, :uniq => true

  cattr_reader :per_page
  attr_accessor :quantity_left
  @@per_page = 5
  named_scope :ps3, :conditions => {:platform_id => Platform.find_by_name("PS3")}
	named_scope :xbox360, :conditions => {:platform_id => Platform.find_by_name("Xbox360")}
  
  has_attached_file :image, :styles => {:medium => "150x150>", :thumb => "100x100>", :icon => "75x75>"}
  
  validates_presence_of     :name, :platform_id, :age_category_id, :quantity
  validates_uniqueness_of :name, :case_sensitive => false
  validates_numericality_of :quantity, :greater_than_or_equal_to => 0,
                                       :unless => Proc.new{|i| i.quantity.blank?}
  validates_inclusion_of :platform, :in => Platform.all,
                                    :unless => Proc.new{|i| i.platform_id.blank?}                                    
  validates_inclusion_of :age_category, :in =>  AgeCategory.all, 
                                        :unless=> Proc.new{|i| i.age_category_id.blank?}
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image,
                                    :content_type => ['image/jpeg','image/png','image/jpg','image/gif'],
                                    :message => 'has invalid format. You can upload images with .gif, .jpg or .png format' 


  def validate
    errors.add_to_base("Category can't be blank") if categories.blank?
  end
  
  define_index do
    indexes description
    indexes :name, :sortable => true 
    indexes platform.name,:as=> :platform_name,:sortable => true
    indexes age_category.name,:as => :aname,:sortable => true
    indexes categories.name,:as => :cname,:sortable => true
    has  age_category_id, platform_id
  end

  def to_param
   "#{id}-#{name}" 
  end
  
  def available_for_shortlisting
    (self.quantity_left = self.quantity - count).zero?
  end     

  def self.browse_by_platform(platform)  
    case platform
      when 'PS3'    ;then  Game.ps3 
      when 'Xbox360';then Game.xbox360 
    end
  end

  def self.browse_by_category(category)
    Category.find_by_name(category).games
  end

  def self.show_all_games
    all  
  end
  
  def find_categories
    categories.collect{|category| category.name}  
  end
  
  private
  
  def count
    users_who_rented.count + users_who_grabbed.count
  end 

end


  #-----------------------------------------------------------------------------------------------------------------
  # def validate
  #     arr = []
  #     Category.all.collect { |x| arr << x.id }
  #     errors.add_to_base("Category can't be blank") if (categories.size.zero?)
  #     errors.add_to_base("Category is not included in the list") if !(category_ids.collect {|x| arr.include?(x)}) && !categories.size.zero?
  #   end
  
  # def validate
  #   all_categories_ids = Category.all.collect{|c| c.id}
  #   errors.add_to_base("Category can't be blank") if category_ids.blank?
  #   unless category_ids.blank?
  #     category_ids.each do |c|
  #       unless all_categories_ids.include?(c)
  #         debugger
  #         errors.add_to_base("Category is not included in the list")
  #         break
  #       end
  #     end
  #   end
  # end
  #-----------------------------------------------------------------------------------------------------------------
  