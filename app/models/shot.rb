class Shot < ApplicationRecord

  belongs_to :user
  belongs_to :project

  MEDIA_URL_EXPIRY = 7.days

  def get_media_url
  	if is_media_url_expired? 
	  	s3_object = S3_BUCKET.object(s3_key)
	  	self.update_attributes(media_url_expiry: MEDIA_URL_EXPIRY.from_now)
	  	s3_media_url = s3_object.presigned_url(:get, expires_in: MEDIA_URL_EXPIRY.seconds.to_i)
	  	self.update_attributes(media_url: s3_media_url)
  	end
  	self.media_url
  end

  def is_media_url_expired?
  	media_url_expiry == nil || media_url_expiry <= Time.now
  end
end
