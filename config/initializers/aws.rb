Aws.config.update({
  region: 'us-east-1',
  credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
})

PRESIGNER = Aws::S3::Presigner.new(client: Aws::S3::Client.new)

S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['S3_BUCKET'])
