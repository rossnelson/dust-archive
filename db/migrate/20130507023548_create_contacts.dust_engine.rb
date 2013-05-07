# This migration comes from dust_engine (originally 20110218002220)
class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :company_name
      t.string :phone
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :message
      t.string :hear

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
