require 'aws-sdk'

class GameEc2

  def initialize
    @aws_access_key = "AKIAIVESJITWA4YPMAYA"
    @aws_secret_access = "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"
    @region = "ap-southeast-2"
  end

  def create_game()
    github_repo = "git@github.com:DiUS/ctf-level-0.git"
    ec2 = AWS::EC2.new(
    :access_key_id => @aws_access_key,
    :secret_access_key => @aws_secret_access,
    :region => @region)
    ami_id = get_ami_id(@region)
    ec2_instance = ec2.instances.create(:image_id => "ami-a148d59b", 
      :user_data => "#!/bin/bash\n yum install git\n mkdir -p /opt/app\n 
                    cd /opt/app && git clone #{github_repo}")
    # check if ec2_instance creation is successful
    return ec2_instance
  end

  def get_game_instance(instance_id)
    ec2 = AWS::EC2.new(
    :access_key_id => @aws_access_key,
    :secret_access_key => @aws_secret_access,
    :region => @region)
    ec2_instance = ec2.client.describe_instances(:instance_ids => [instance_id])
    # check if ec2_instance creation is successful
    return ec2_instance
  end

  private

  def get_ami_id(region)
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