class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.boolean :active
      #t.string  :partial_name
      t.string  :meta_title
      t.text    :meta_description
      t.string  :filename
      t.string  :nav_link
      t.string  :classes

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
