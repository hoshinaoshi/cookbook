#
# Cookbook Name:: init
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute 'yum-update' do
  user 'root'
  command 'yum -y update'
  action :run
end

%w{openssl-devel sqlite-devel make gcc zlib-devel openssl-devel readline-devel ncurses-devel gdbm-devel db4-devel libffi-devel libyaml-devel ImageMagick-devel ImageMagick libxml2 libxml2-devel libxslt libxslt-devel}.each do |pkg|
  package pkg do
    action :install
  end
end
