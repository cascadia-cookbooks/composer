#
# Cookbook Name:: cop_composer
# Recipe:: install
# Author:: Copious Inc. <engineering@copiousinc.com>
#

binary = node['composer']['install']['path']

if node['composer']['install']['version'] == 'latest'
    download = 'https://getcomposer.org/composer.phar'
else
    version  = node['composer']['install']['version']
    download = "https://getcomposer.org/download/#{version}/composer.phar"
    checksum = node['composer']['install']['checksum']
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
