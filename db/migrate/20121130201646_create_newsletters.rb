class CreateNewsletters < ActiveRecord::Migration
  def self.up
    create_table :newsletters do |t|
      t.string :title
      t.string :document
      t.text :summary
      t.timestamps
    end
  end

	CmsMenuItem.create({:title =>"Newsletters", :controller_name => "newsletters", :url => "/newsletters"})

	MenuItem.create({:title => "All Newsletters", :url => "/all-newsletters", :active => true})
	
  def self.down
    drop_table :newsletters
  end
end
