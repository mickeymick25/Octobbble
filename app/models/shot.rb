class Shot < ApplicationRecord

  belongs_to :user
  belongs_to :project

  # mount_uploader :s3_key, UserShotUploader

  def generate_s3_link
  	s3_object = S3_BUCKET.object(s3_key)
  	s3_object.presigned_url(:get, expires_in: 3600)
  end
end
