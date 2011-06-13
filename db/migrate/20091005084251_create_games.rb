class CreateGames < ActiveRecord::Migration
  #Fix- you dont need to repeat if the columns have same data type
  def self.up
    create_table :games do |t|
	    t.string :name
	    t.text :description
	    t.string :platform
	    t.string :category
	    t.string :age_category
	    t.string :image_file_name
	    t.string :image_content_type
	    t.integer :image_file_size
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
