class Batch < ActiveRecord::Base
  attr_accessible :user_id, :submission_id, :directory_id

  has_many   :account_files
  belongs_to :user, :dependent => :destroy
  belongs_to :directory

  def determine_recipiant
    departments = YAML.load(File.read("#{Rails.root}/config/professional_departments.yml"))
    departments[self.user.department.downcase].symbolize_keys
  end

  def send_mail(this_user)
    PostOffice.new_files_uploaded(self, self.user).deliver unless this_user.has_any_of_these_roles?(["admin", "management"])
    PostOffice.inform_client_of_uploaded_files(self, self.user).deliver unless this_user.has_role?("client")
  end

end
