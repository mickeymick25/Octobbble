class Project < ApplicationRecord
  belongs_to :user
  mount_uploader :project_cover, UserShotUploader
end
