# This migration comes from dust_engine (originally 20110218000641)
class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :title
      t.string :classes
      t.integer :position
      t.integer :page_id
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt

      t.timestamps
    end
  end
end
