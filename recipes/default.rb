#
# Cookbook Name:: cop_composer
# Recipe:: default
# Author:: Copious Inc. <engineering@copiousinc.com>
#

include_recipe 'cop_composer::databag'
include_recipe 'cop_composer::install'
include_recipe 'cop_composer::configure'
