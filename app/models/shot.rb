class Shot < ApplicationRecord

  belongs_to :user
  belongs_to :project

  mount_uploader :user_shot, UserShotUploader
end
