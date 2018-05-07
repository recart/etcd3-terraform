require 'awspec'
require 'parseconfig'

tf_state = JSON.parse(
  File.open('.kitchen/kitchen-terraform/default-aws/terraform.tfstate').read
)

vpc_id = tf_state['modules'][0]['outputs']['vpc_id']['value']
gateway_id = tf_state['modules'][0]['outputs']['gateway_id']['value']

describe vpc('test-vpc-main') do
  it { should exist }
  its(:vpc_id) { should eq vpc_id }
end

describe internet_gateway('public0') do
  it { should exist }
  its(:internet_gateway_id) { should eq gateway_id }
end

describe subnet('public0') do
  it { should exist }
  its(:vpc_id) { should eq vpc_id }
end

describe subnet('private0') do
  it { should exist }
  its(:vpc_id) { should eq vpc_id }
end

describe subnet('public1') do
  it { should exist }
  its(:vpc_id) { should eq vpc_id }
end

describe subnet('private1') do
  it { should exist }
  its(:vpc_id) { should eq vpc_id }
end
