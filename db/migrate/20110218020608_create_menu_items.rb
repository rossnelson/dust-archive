class CreateMenuItems < ActiveRecord::Migration
  def self.up
    create_table :menu_items do |t|
      t.string :title
      t.string :url
      t.boolean :active
      t.integer :lft
      t.integer :rgt
      t.integer :parent_id
			t.references :linkable, :polymorphic => true
      t.timestamps
    end
  end

  def self.down
    drop_table :menu_items
  end
end
