class CreateMenuItems < ActiveRecord::Migration
  def self.up
    create_table :menu_items do |t|
      t.string :title, :default => "Empty"
      t.string :url, :default => "/empty"
      t.boolean :active, :default => 0
      
      t.integer :lft
      t.integer :rgt
      t.integer :parent_id
      t.integer :menu_id, :default => 0

      t.references :linkable, :polymorphic => true
      t.timestamps
    end
  end

  def self.down
    drop_table :menu_items
  end
end
