class CreateKeys < ActiveRecord::Migration
  def self.up
    create_table :keys do |t|
      t.string :word
      t.timestamps
    end
  end

  def self.down
    drop_table :keys
  end
end
