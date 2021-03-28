HedgeDoc plugin for Redmine
===========================

[![Rate at redmine.org](https://img.shields.io/badge/rate%20at-redmine.org-blue.svg?style=fla)](https://www.redmine.org/plugins/redmine_hedgedoc) [![Run Rubocop](https://github.com/AlphaNodes/redmine_hedgedoc/workflows/Run%20Rubocop/badge.svg)](https://github.com/AlphaNodes/redmine_hedgedoc/actions/workflows/rubocop.yml) [![Run Brakeman](https://github.com/AlphaNodes/redmine_hedgedoc/workflows/Run%20Brakeman/badge.svg)](https://github.com/AlphaNodes/redmine_hedgedoc/actions/workflows/brakeman.yml) [![Run Tests](https://github.com/AlphaNodes/redmine_hedgedoc/workflows/Tests/badge.svg)](https://github.com/AlphaNodes/redmine_hedgedoc/actions/workflows/tests.yml)

Features
--------

* Show list of own [HedgeDoc](https://hedgedoc.org/) pads in [Redmine](https://www.redmine.org/)
* Show HedgeDoc pads in [Redmine](https://www.redmine.org/) projects, if pad name has redmine identifier as prefix. Eg. MyProject: MyPad

Redmine Requirements
--------------------

* Redmine version >= 4.1
* Redmine Plugin: [additionals](https://github.com/alphanodes/additionals)
* Ruby version >= 2.6.0

HedgeDoc Requirements
---------------------

* HedgeDoc version: all
* E-Mail authentification

Installation
------------

Install ``redmine_hedgedoc`` plugin for `Redmine`

    cd $REDMINE_ROOT
    git clone git://github.com/alphanodes/additionals.git plugins/additionals
    git clone git://github.com/alphanodes/redmine_hedgedoc.git plugins/redmine_hedgedoc
    bundle install --without development test
    bundle exec rake redmine:plugins:migrate RAILS_ENV=production

Restart Redmine (application server) and you should see the plugin show up in the Plugins page.


Configuration
-------------

Redmine needs access to [HedgeDoc](https://hedgedoc.org/) database. Add in your config/database.yml an paragraph names "hedgedoc", e.g.

    hedgedoc:
      adapter: postgresql
      database: hedgedoc
      host: localhost
      username: hedgedoc
      password: hedgedoc
      encoding: utf8
      schema_search_path: public

Uninstall
---------

Uninstall ``redmine_hedgedoc``

    cd $REDMINE_ROOT
    rm -rf plugins/redmine_hedgedoc

Restart Redmine (application server)
