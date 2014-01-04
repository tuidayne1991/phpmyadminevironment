#
# Cookbook Name:: xcode
# Recipe:: default
#
#

include_recipe 'apt'
# include_recipe 'git'
include_recipe 'nginx'
include_recipe 'mysql::server'

apt_package "php5-fpm" do
  action :install
end

service "php5-fpm" do
      supports :status => true, :restart => true, :reload => true
end

include_recipe 'php::module_mysql'

# create nginx server block file
template "#{node['nginx']['dir']}/sites-available/default" do
  source "nginx_default.erb"
  owner "root"
  group "root"
  mode 00755
  notifies :reload, "service[nginx]", :delayed
  notifies :reload, "service[php5-fpm]", :delayed
end

# Running MySQL scripts

execute "mysql-install-privileges" do
      command "mysql -u root -p#{node['mysql']['server_root_password']} < /vagrant/command.sql"      
end

