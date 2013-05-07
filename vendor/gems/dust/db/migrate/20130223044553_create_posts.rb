class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :file
      t.boolean :published
      t.datetime :published_at
      t.boolean :share
      t.string :share_type
      t.text :body

      t.timestamps
    end
  end
end
