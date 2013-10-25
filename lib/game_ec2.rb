require 'aws-sdk'

class GameEc2

  def initialize
    @aws_access_key = current_user.aws_access_key
    @aws_secret_access = current_user.aws_secret_access
    @region = "ap-southeast-2"
    @keypair_name = current_user.keypair_name
  end

  def create_game(github_repo)
    ec2 = AWS::EC2.new(
    :access_key_id => @aws_access_key,
    :secret_access_key => @aws_secret_access,
    :region => @region)
    ami_id = get_ami_id(@region)
    ec2_instance = ec2.instances.create(:image_id => "ami-a148d59b", :key_pair => AWS::EC2::KeyPair.new(@keypair_name),
      :user_data => "#!/bin/bash -l\n yum -y install git\n mkdir -p /opt/app\n 
cd /opt/app && git clone #{github_repo} && cd stripes-level-0 && chmod +x install.sh && ./install.sh\n cd /opt/app/stripes-level-0 && nohup ./install.sh &")
    # check if ec2_instance creation is successful
    return ec2_instance
  end

  def get_game_instance(instance_id)
    ec2 = AWS::EC2.new(
    :access_key_id => @aws_access_key,
    :secret_access_key => @aws_secret_access,
    :region => @region)
    ec2_instance = ec2.client.describe_instances(:instance_ids => ["#{instance_id}"])
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