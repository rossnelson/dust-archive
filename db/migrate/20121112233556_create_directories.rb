class CreateDirectories < ActiveRecord::Migration
  def change
    create_table :directories do |t|
      t.string :title
      t.references :user
      t.integer :parent_directory_id

      t.timestamps
    end
    add_index :directories, :user_id
  end
end
