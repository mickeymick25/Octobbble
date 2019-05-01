class Shot < ApplicationRecord
  belongs_to :user, dependent: :destroy
  mount_uploader :user_shot, UserShotUploader
end
