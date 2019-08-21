class Shot < ApplicationRecord

  belongs_to :user
  belongs_to :project

  mount_uploader :s3_key, UserShotUploader
end
