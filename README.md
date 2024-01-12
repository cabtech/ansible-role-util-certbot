----
# ansible-role-util-certbot

## GitHub Actions: Build Status
![](https://github.com/cabtech/ansible-role-util-certbot/workflows/linter/badge.svg)

## Purpose
Installs certbot from [Let's Encrypt](https://letsencrypt.org/)

## Default variables
| Name | Type | Default | Purpose |
| ---- | ---- | ------- | ------- |
| certbot_domains | list(string) | [] | Used to render a list of domains for certbot to reqeust |
| certbot_install_method | string | snap | how to install Certbot |
| certbot_renew_using_cron | Boolean | false | flags whether to add a cron job to automate renewal |

## Supported Distros
Ubuntu 16+

## To Do
- add variable to control cron job
****
