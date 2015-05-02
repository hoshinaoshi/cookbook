#
# Cookbook Name:: rails
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{gcc-c++ curl-devel httpd-devel apr-devel apr-util-devel}.each do |pkg|
  package pkg do
    action :install
  end
end

gem_package 'nokogiri' do
  action :install
  gem_binary('/home/ec2-user/.rbenv/versions/2.2.2/bin/gem')
  options('-- --use-system-libraries')
end

gem_package 'rails' do
  action :install
  gem_binary('/home/ec2-user/.rbenv/versions/2.2.2/bin/gem')
  version '4.2.1'
end

