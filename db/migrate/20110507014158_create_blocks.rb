class CreateBlocks < ActiveRecord::Migration
  def self.up
    create_table :blocks do |t|
      t.boolean :show_title
      t.string :title
      t.text :body
      t.string :where_to_show
      t.text :show
      t.boolean :show_title
      t.string :column_span
      t.string :column_offset
      t.string :classes
      t.integer :weight
      t.string :partial_name

      t.timestamps
    end
  end
  
  def self.down
    drop_table :blocks
  end
end
