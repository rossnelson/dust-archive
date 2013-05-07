# This migration comes from dust_engine (originally 20110218000640)
class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string  :meta_title
      t.text    :meta_description
      t.string  :classes

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
