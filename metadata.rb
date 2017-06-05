name 'cop_composer'
maintainer 'Copious Inc.'
maintainer_email 'engineering@copiousinc.com'
license 'MIT'
description 'Installs and configures Composer.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.1'

source_url 'https://github.com/copious-cookbooks/composer'
issues_url 'https://github.com/copious-cookbooks/composer/issues'

supports 'ubuntu', '>= 14.04'
supports 'debian', '>= 7'
supports 'centos', '>= 7'
