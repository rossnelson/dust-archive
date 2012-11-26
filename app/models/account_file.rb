class AccountFile < ActiveRecord::Base
  attr_accessible :title, :user_id, :content, :directory_id

  #has_attached_file :content,
  #                  :url => '/:class/:id/:style.:extension',
  #                  :path => ':rails_root/account_files/:class/:id_partition/:style.:extension'
  
  mount_uploader :content, AccountFileContentUploader

  belongs_to :directory
  belongs_to :user
  belongs_to :batch

  def ext_name
    ext = File.extname(content_url)
    ext_name = ext.gsub(/[.]/, '')
    ext_name.downcase
  end

  def final_title
    title || content_url
  end
  
  def content_filename
    read_attribute(:content)
  end

end