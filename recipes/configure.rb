#
# Cookbook Name:: cop_composer
# Recipe:: configure
# Author:: Copious Inc. <engineering@copiousinc.com>
#

home = node['composer']['home']

directory home do
    action :create
    owner  'root'
    group  'root'
    mode   0755
end

template "#{home}/auth.json" do
    cookbook 'cop_composer'
    source   'auth.json.erb'
    backup   false
    action   :create
    owner    'root'
    group    'root'
    mode     0644
end
