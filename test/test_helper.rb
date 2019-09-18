ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'rspec/mocks/standalone'

include RSpec::Mocks::ExampleMethods

GENERATED_PRESIGNED_URL = "http://presigned.url"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  s3_bucket = instance_double("Aws::S3::Bucket")
  s3_object = instance_double("Aws::S3::Object")
  Shot::S3_BUCKET = s3_bucket
  allow(s3_bucket).to receive(:object) { s3_object }
  allow(s3_object).to receive(:presigned_url) { GENERATED_PRESIGNED_URL }
end
