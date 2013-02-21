class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :title
      t.string :nestable
      t.text :desc

      t.timestamps
    end
  end
end
