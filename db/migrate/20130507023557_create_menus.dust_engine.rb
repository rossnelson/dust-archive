# This migration comes from dust_engine (originally 20130220051658)
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
