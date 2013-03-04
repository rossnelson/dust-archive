class AddSortingToSections < ActiveRecord::Migration
  def change
    add_column :sections, :parent_id, :integer
    add_column :sections, :lft, :integer
    add_column :sections, :rgt, :integer
  end
end
