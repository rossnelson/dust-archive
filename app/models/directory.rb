class Directory < ActiveRecord::Base

  belongs_to :user
  has_many   :account_files, :dependent => :destroy

  has_many :sub_directories, :class_name => "Directory", :foreign_key => "parent_directory_id", :dependent => :destroy
  belongs_to  :parent_directory, :class_name => "Directory"

  def find_all_parents
    breadcrumbs = []
    parent_id = self.parent_directory_id
    until parent_id == nil
      breadcrumbs << parent = Directory.find(parent_id)
      parent_id = parent.parent_directory_id
    end
    breadcrumbs.reverse
  end

  def contents_count
    dirs = sub_directories.count
    files = account_files.count
    dirs + files
  end

end
