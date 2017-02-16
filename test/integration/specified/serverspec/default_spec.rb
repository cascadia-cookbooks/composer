require 'spec_helper'

describe 'cop_composer::default' do
  describe file('/usr/local/bin/composer.phar') do
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '755' }
    it { should contain("VERSION = '1.3.2'") }
  end

  describe file('/opt/composer') do
    it { should be_directory }
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '755' }
  end

  describe file('/opt/composer/auth.json') do
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '644' }
    it { should contain('"username": "123"') }
    it { should contain('"password": "456"') }
    it { should contain('"github.com": "789"') }
  end

  describe command('whereis composer.phar') do
    its(:stdout) { should match /\/usr\/local\/bin\/composer\.phar/ }
  end
end
