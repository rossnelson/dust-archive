class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.boolean :active
      t.string  :partial_name
      t.text    :description
      t.string  :keywords
      t.string  :title
      t.string  :filename
      t.string  :nav_link
	    t.string  :heading
      t.string  :classes
      
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
