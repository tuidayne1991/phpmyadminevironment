#
# Cookbook Name:: xcode
# Recipe:: default
#
#
execute "yii-migration" do
      command "cd /vagrant/webapp/protected; { echo \"yes\"; } | ./yiic migrate up"
end
