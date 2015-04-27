#
# Cookbook Name:: ssh
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
template '/home/ec2-user/.ssh/id_rsa' do
  path '/home/ec2-user/.ssh/id_rsa'
  user 'ec2-user'
  owner 'ec2-user'
  group 'ec2-user'
  mode 0400
end

template '/home/ec2-user/.ssh/id_rsa.pub' do
  path '/home/ec2-user/.ssh/id_rsa.pub'
  user 'ec2-user'
  owner 'ec2-user'
  group 'ec2-user'
  mode 0400
end
