class Project < ApplicationRecord

  belongs_to :user
  has_many :shots

  mount_uploader :cover, CoverUploader

end
