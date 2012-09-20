#
# Cookbook Name:: mailgun
# Recipe:: default
#
# Copyright 2012, Rackspace
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe 'chef_handler'

dbag = Chef::EncryptedDataBagItem.load("mailgun", node[:mailgun][:data_bag_name])
login = dbag['login']
password = dbag['password']

gem_package "pony" do
  action :install
end

cookbook_file "#{node['chef_handler']['handler_path']}/mailgun_sender.rb" do
  source "mailgun_sender.rb"
  owner "root"
  group "root"
  mode 0755
end

chef_handler "Mailgun::Mailgun_Sender" do
  source "#{node.chef_handler.handler_path}/mailgun_sender.rb"
  arguments [login, password]
  action :enable
end
