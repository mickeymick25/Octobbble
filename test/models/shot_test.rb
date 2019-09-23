require 'test_helper'

class ShotTest < ActiveSupport::TestCase

  test "shot with image png media should be image" do
    assert shots(:image_shot).is_image? 
  end

  test "shot with video mpg media should not be image" do
    assert ! shots(:video_shot).is_image? 
  end

  test "shot with video mpg media should be video" do
    assert shots(:video_shot).is_video? 
  end

  test "get media url for 1st time should return s3 presigned url" do
  shot = shots(:shot_without_url)

    assert(shot.get_media_url == GENERATED_PRESIGNED_URL)
  end

  test "get media url for 1st time should store media url" do
    shot = shots(:shot_without_url)
    shot.get_media_url
    assert(shot.media_url != nil)
  end

  test "get media url for 1st time should store media url expiry" do
    shot = shots(:shot_without_url)
    shot.get_media_url
    assert(shot.media_url_expiry != nil)
  end

  test "get unexpired media url should not generate new url" do
    shot = shots(:image_shot)
    assert(shot.get_media_url != GENERATED_PRESIGNED_URL)
  end

  test "get expired media url should generate new url" do
    shot = shots(:image_shot_expired_url)
    assert(shot.get_media_url == GENERATED_PRESIGNED_URL)
  end
end
