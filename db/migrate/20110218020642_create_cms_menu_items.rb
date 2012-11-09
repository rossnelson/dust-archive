class CreateCmsMenuItems < ActiveRecord::Migration
  def self.up
    create_table :cms_menu_items do |t|
      t.string :title
      t.string :url
      t.string :controller_name
      t.integer :lft
      t.integer :rgt
      t.integer :parent_id
      t.timestamps
    end
  end

  def self.down
    drop_table :cms_menu_items
  end
end
