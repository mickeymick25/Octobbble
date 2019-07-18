class Project < ApplicationRecord

  belongs_to :user
  has_many :shots

  mount_uploader :cover, CoverUploader
  mount_uploader :clientlogo, ClientlogoUploader

end
