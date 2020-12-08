require 'tempfile'
require 'aws-sdk-s3'
require 'rack/mime'
class S3Client
  def initialize(client:, bucket:)
    @client = client
    @bucket = bucket
  end
  def upload(path, data)
    resource = Aws::S3::Resource.new client: @client
    object   = resource.bucket(@bucket).object(path)
    type     = Rack::Mime::MIME_TYPES[File.extname(path)]
    if type
      # `body` can be a string or IO
      # Arguments for Aws::S3::Object#put are @ https://github.com/aws/aws-sdk-ruby/blob/60ef356300e59ef772a84c891e9fa34af4bb06cd/gems/aws-sdk-s3/lib/aws-sdk-s3/object.rb#L770-L797
      object.put(body: data, content_type: type)
    else
      raise ArgumentError, "Could not identify out the content type for #{path.inspect}"
    end
  end
  # NOTE: there are also `copy_to` and `copy_from` methods, but that would have exceeded my timebox
  def download(path, &block)
    resource = Aws::S3::Resource.new(client: @client).bucket(@bucket).object(path)
    local = Tempfile.new
    resource.download_file local.path
    local.rewind
    block.call local
  ensure
    local&.close
    local&.unlink # deletes the temp file
  end
end
require 'aws-sdk-s3'
aws_credentials = Aws::Credentials.new(
  ENV.fetch('AWS_ACCESS_KEY_ID'),
  ENV.fetch('AWS_SECRET_ACCESS_KEY'),
)
client = S3Client.new(
  client: Aws::S3::Client.new(region: ENV.fetch('AWS_REGION'), credentials: aws_credentials),
  bucket: ENV.fetch('AWS_BUCKET_NAME'),
)
idk = client.upload 'test.png', File.binread('/Users/josh/code/wabi-sabi-christmas/wabi-sabi-bitmoji-josh.png')
require "pry"
binding().pry
client.download 'test.png' do |tempfile|
  require "pry"
  binding().pry
end
