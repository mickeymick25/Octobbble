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
end
