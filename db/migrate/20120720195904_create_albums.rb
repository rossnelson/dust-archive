class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.string :title
      t.string :filename
      t.text :desc
      t.boolean :active
      t.string :heading
      t.string :nav
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.timestamps
    end

    CmsMenuItem.create({:title =>"Albums", :controller_name => "albums", :url => "/albums"})
    MenuItem.create({:title => "All Albums", :url => "/all/albums", :active => true})

    create_table :photos do |t|
      t.string :title
      t.text :desc
      t.date :date_shot
      t.string :location
      t.integer :album_id
      t.string  :file_file_name
      t.string  :file_content_type
      t.integer :file_file_size
      t.datetime :file_updated_at
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.timestamps
    end

  end

  def self.down
    drop_table :albums
    drop_table :photos
  end
end
