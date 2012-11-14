class CreateAccountFiles < ActiveRecord::Migration
  def change
    create_table :account_files do |t|
      t.string :title
      t.references :directory
      t.references :user
      t.references :batch
      t.string :content

      t.timestamps
    end
    add_index :account_files, :directory_id
    add_index :account_files, :user_id
    add_index :account_files, :batch_id
  end
end
