class CreateBatches < ActiveRecord::Migration
  def change
    create_table :batches do |t|
      t.integer :submission_id
      t.references :user
      t.references :directory

      t.timestamps
    end
    add_index :batches, :user_id
    add_index :batches, :directory_id
  end
end
