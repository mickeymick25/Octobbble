class Shot < ApplicationRecord

  belongs_to :user
  belongs_to :project

  # mount_uploader :s3_key, UserShotUploader

  def generate_s3_link
  	params = {
      bucket: S3_BUCKET.name,
      key: s3_key,
      expires_in: 86400
    }
    PRESIGNER.presigned_url(:get_object, params)      
  end
end
