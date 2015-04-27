#
# Cookbook Name:: vim
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package 'vim-enhanced' do
  action :install
end

template '~/.vimrc' do
  path '/home/ec2-user/.vimrc'
  user 'ec2-user'
  owner 'ec2-user'
  mode 0664
end

bash 'mkdir -p ~/.vim/bundle' do
  user 'ec2-user'
  code 'mkdir -p /home/ec2-user/.vim/bundle'
end

git "/home/ec2-user/.vim/bundle/neobundle.vim" do
  repository 'git://github.com/Shougo/neobundle.vim.git'
  action :checkout
  user 'ec2-user'
  group 'ec2-user'
end

execute 'neobundle install' do
  command "vim +\":NeoBundleInstall\" +:q"
  user 'ec2-user'
  group 'ec2-user'
  environment 'HOME' => "/home/ec2-user"
end
