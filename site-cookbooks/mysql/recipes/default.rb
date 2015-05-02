#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{mysql mysql-server mysql-devel mysql55 mysql55-common mysql55-libs mysql55-server}.each do |pkg|
  package pkg do
    action :remove
  end
end

%w{mysql mysql-server mysql-devel}.each do |pkg|
  package pkg do
    action :install
  end
end

service 'mysqld' do
  action [:enable, :start]
end

bash "mysql_secure_installation" do
  code <<-EOC
    mysql -u root -e "DELETE FROM mysql.user WHERE User='';"
    mysql -u root -e "DROP DATABASE test;"
    mysql -u root -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
    mysql -u root -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
    mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('#{node['mysql']['root_password']}');" -D mysql
    mysql -u root -p#{node['mysql']['root_password']} -e "SET PASSWORD FOR 'root'@'127.0.0.1' = PASSWORD('#{node['mysql']['root_password']}');" -D mysql
    mysql -u root -p#{node['mysql']['root_password']} -e "SET PASSWORD FOR 'root'@'::1' = PASSWORD('#{node['mysql']['root_password']}');" -D mysql
    mysql -u root -p#{node['mysql']['root_password']} -e "FLUSH PRIVILEGES;"
  EOC
  only_if "mysql -u root -e 'show databases'"
end

template "/tmp/grants.sql" do
    owner "root"
    group "root"
    mode "0600"
    variables(
        user: 'ec2-user',
        password: node['mysql']['user_password'],
        database: '*'
    )
    notifies :run, "execute[mysql-create-user]", :immediately
end

execute "mysql-create-user" do
    command "/usr/bin/mysql -uroot -p#{node['mysql']['root_password']}  < /tmp/grants.sql"
    action :nothing
end
