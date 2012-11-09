class CreateTestimonials < ActiveRecord::Migration
  def self.up
    create_table :testimonials do |t|
      t.text :quote
      t.string :attribution
      t.boolean :approved
      t.timestamps
    end
  end
	
  def self.down
    drop_table :testimonials
  end
end
