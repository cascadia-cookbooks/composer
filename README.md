# Composer Cookbook
This will install and configure Composer.phar. It does not install
prerequisites like PHP.

## Platforms
- Debian
- Rhel

## Attributes
* `node['composer']['install']['version']` (string) defaults to `latest`, when
  set to `1.2.3` it will check for that version of composer.phar on [the GitHub
mirror](https://github.com/composer/getcomposer.org/tree/master/web/download).
* `node['composer']['install']['checksum']` (string) no default, its optional
  when using a specified version for composer, give it a SHA1 checksum if you
want to compare it against the binary.
* `node['composer']['install']['path']` (string) defaults to
  `/usr/local/bin/composer.phar`, where to install the binary.
* `node['composer']['home']` (string) defaults to `/opt/composer`, where to
  install composer config files like `auth.json`.
* `node['composer']['prestissimo']` (boolean) defaults to `true`, see 
  [hirak/prestissimo](https://github.com/hirak/prestissimo) for more info

## Usage
Here's an example `web` role that has some Composer settings.

```ruby
name 'web'
description 'Everything we need for a webhead!'

override_attributes(
    ...
    'composer' => {
        'install' => {
            'version' => 'latest'
        },
        'auth' => {
            'http-basic' => {
                'repo.magento.com' => {
                    'user' => 'USER_KEY',
                    'pass' => 'PASS_KEY'
                }
            },
            'github-oauth' => {
                'github.com' => 'OAUTH_TOKEN'
            }
        }
    }
    ...
)

run_list(
    '..., recipe[cop_composer], ...'
)
```

NOTE: You will be required to include a `depends` for this cookbook inside YOUR
cookbook's `metadata.rb` file.

```ruby
...
depends 'cop_composer', git: 'git@github.com:copious-cookbooks/composer.git'
...
```
