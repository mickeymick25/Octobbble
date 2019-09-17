class Shot < ApplicationRecord

  belongs_to :user
  belongs_to :project

  MEDIA_URL_EXPIRY = 7.days
  MEDIA_TYPE_IMAGE = "image"
  MEDIA_TYPE_VIDEO = "video"
  MEDIA_TYPE_UNSUPPORTED = "unsupported"

  def is_image?
    get_media_type == MEDIA_TYPE_IMAGE
  end

  def is_video?
    get_media_type == MEDIA_TYPE_VIDEO
  end

  def get_media_type
    case mime_type
    when /\Aimage/
      MEDIA_TYPE_IMAGE
    when /\Avideo/
      MEDIA_TYPE_VIDEO
    else
      MEDIA_TYPE_UNSUPPORTED
    end
  end

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
