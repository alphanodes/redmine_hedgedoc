CodiMD plugin for Redmine
==================================

[![Rate at redmine.org](https://img.shields.io/badge/rate%20at-redmine.org-blue.svg?style=fla)](https://www.redmine.org/plugins/redmine_codimd)

Features
--------

* Show own CodiMD pads in redmine
* Show CodiMD pads in redmine projects, if pad name has redmine identifier as prefix


Requirements
------------

* Redmine version >= 3.4.0
* Redmine Plugin: [additionals](https://github.com/alphanodes/additionals)
* Ruby version >= 2.2.0


Installation
------------

Install ``redmine_codimd`` plugin for `Redmine`

    cd $REDMINE_ROOT
    git clone git://github.com/alphanodes/redmine_codimd.git plugins/redmine_codimd
    git clone git://github.com/alphanodes/additionals.git plugins/additionals
    bundle install --without development test
    bundle exec rake redmine:plugins:migrate RAILS_ENV=production

Restart Redmine (application server) and you should see the plugin show up in the Plugins page.


Configuration
-------------

Redmine needs access to CodiMD database. Add in your config/database.yml an paragraph names "codimd", e.g.

    codimd:
      adapter: postgresql
      database: codimd
      host: localhost
      username: codimd
      password: codimd
      encoding: utf8
      schema_search_path: public



Uninstall
---------

Uninstall ``redmine_codimd``

    cd $REDMINE_ROOT
    bundle exec rake redmine:plugins:migrate NAME=redmine_codimd VERSION=0 RAILS_ENV=production
    rm -rf plugins/redmine_codimd

Restart Redmine (application server)
