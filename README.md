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
    '..., recipe[cop_composer::default], ...'
)
```

## Data Bags

Databags are integrated into this cookbook. It assumes it lives in your chef
defined databag folder under `composer/ENVIRONMENT.json` where `ENVIRONMENT` is
the environment in which the credentials are for. It will use the
`Chef::Config[:encrypted_data_bag_secret]` to encrypt the information.

The recipe will loop through the structure defined in the default attribute
structure as seen above. You should not set the credentials there but define the
expected values to be provided. The databag structure should be similar to the
following:


```json
{
  "id": "ENVIRONMENT",
  "auth": {
    "http-basic": {
      "HOST1": {
        "user": "USER_KEY",
        "pass": "PASS_KEY"
      },
      "HOST2": {
        "user": "USER_KEY2",
        "pass": "PASS_KEY2"
      },
    },
    "github-oauth": {
      "github.com": {
        "token": "OAUTH_TOKEN"
      }
    }
  }
}
```

NOTE: You will be required to include a `depends` for this cookbook inside YOUR
cookbook's `metadata.rb` file.

```ruby
...
depends 'cop_composer', git: 'git@github.com:copious-cookbooks/composer.git'
...
```
