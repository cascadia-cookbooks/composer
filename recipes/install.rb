#
# Cookbook Name:: cop_composer
# Recipe:: install
# Author:: Copious Inc. <engineering@copiousinc.com>
#

version = node['composer']['install']['version']
binary  = node['composer']['binary']

remote_file 'install composer binary' do
    path   binary['path']
    source version == 'latest' ? 'https://getcomposer.org/composer.phar' : "https://getcomposer.org/download/#{version}/composer.phar"
    owner  binary['user']
    group  binary['group']
    mode   binary['mode']
end

remote_file binary do
    source   download
    owner    'root'
    group    'root'
    mode     0755
    not_if { File.exist?(binary) }
end

execute 'validate against checksum' do
    action     :run
    subscribes :run, "remote_file[#{binary}]", :immediately
    command    "openssl sha1 #{binary} | grep #{checksum}"
    only_if    { node['composer']['install'].attribute?('checksum') }
end
