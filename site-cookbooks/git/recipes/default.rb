#
# Cookbook Name:: git
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package 'git' do
  action :install
end

template '/home/ec2-user/.gitconfig' do
  path '/home/ec2-user/.gitconfig'
  user 'ec2-user'
  owner 'ec2-user'
  group 'ec2-user'
  mode 0644
end
