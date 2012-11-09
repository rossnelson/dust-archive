class CreateNivoTables < ActiveRecord::Migration
  def self.up
      create_table :slides, :force => true do |t|
    t.text :caption
    t.string :url
    t.boolean :active
    t.integer :position
    t.integer :width
    t.integer :height
    t.string :image
    t.datetime :image_updated_at
    t.timestamps
  end

    CmsMenuItem.create({:title =>"Slides", :controller_name => "nivo/slides", :url => "/nivo/slides"})
  end

  def self.down
    drop_table :slides
    item = CmsMenuItem.find_by_title("Slides")
    item.destroy
  end
end
