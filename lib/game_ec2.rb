require 'aws-sdk'

module GameEc2
  aws_access_key = "AKIAIVESJITWA4YPMAYA"
  aws_secret_access = "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"
  region = "ap-southeast-2"
  def self.create_game(aws_access_key, aws_secret_access, region)
    ec2 = AWS::EC2.new(
    :access_key_id => aws_access_key,
    :secret_access_key => aws_secret_access,
    :region => region)
    ami_id = get_ami_id(region)
    ec2_instance = ec2.instances.create(:image_id => ami_id)
    # check if ec2_instance creation is successful
  end

  def self.get_ami_id(region)
    case region
    when "us-east-1"
    when "us-east-2"
    when "ap-southeast-2"
      return "ami-a148d59b"
    else
      puts "Invalid region"
    end
  end
end