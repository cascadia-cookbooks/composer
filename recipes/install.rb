#
# Cookbook Name:: cop_composer
# Recipe:: install
# Author:: Copious Inc. <engineering@copiousinc.com>
#

version = node['composer']['install']['version']
binary  = node['composer']['binary']

# Check if requested version is 'latest'
if version == 'latest'
    # Require additional Ruby stdlib packages
    require 'net/http'
    require 'json'

    # Craft URI for GitHub API - latest release from composer/composer repository
    uri = URI('https://api.github.com/repos/composer/composer/releases/latest')
    # Retrieve JSON response from API
    response = Net::HTTP.get(uri)
    # Parse release tag from JSON
    version = JSON.parse(response)["tag_name"]
end

remote_file 'install composer binary' do
    path   binary['path']
    source "https://getcomposer.org/download/#{version}/composer.phar"
    owner  binary['user']
    group  binary['group']
    mode   binary['mode']
end

execute 'validate binary against checksum' do
    action :nothing
    subscribes :run, 'remote_file[composer binary]', :immediately
    command "openssl sha1 #{binary['path']} | grep #{node['composer']['install']['checksum']}"
    only_if { node['composer']['install'].attribute?('checksum') }
end

execute 'Install Composer plugin Prestissimo' do
    command "#{binary['path']} global require hirak/prestissimo"
    user    binary['user']
    only_if { node['composer']['prestissimo'] }
    not_if  "#{binary['path']} global show | grep prestissimo", :user => binary['user']
end
