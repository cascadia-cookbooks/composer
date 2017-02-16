#
# Cookbook Name:: cop_composer
# Recipe:: configure
# Author:: Copious Inc. <engineering@copiousinc.com>
#

directory node['composer']['home'] do
    action :create
    owner  'root'
    group  'root'
    mode   0755
end

template "#{node['composer']['home']}/auth.json" do
    cookbook 'cop_composer'
    source   'auth.json.erb'
    backup   false
    action   :create
    owner    'root'
    group    'root'
    mode     0644
end
