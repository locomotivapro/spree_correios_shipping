SpreeCorreiosShipping
=====================
[![Code Climate](https://codeclimate.com/github/locomotivapro/spree_correios_shipping/badges/gpa.svg)](https://codeclimate.com/github/locomotivapro/spree_correios_shipping)

This is a gem to allow use Correios service for shipping methods in spree
Currently just tested and working with spree > 3.1

There is a 1.2 spree implementation, just use 1-2-stable branch.

## Installation

1. Add the following to your Gemfile

    gem 'spree_correios_shipping'

2. Run `bundle install`

3. To copy and apply migrations run: `rails g spree_correios_shipping:install`

You will need setup some confs in your app

## Configuring

1. Go to settings and add preferences of settings to Correios.

2. You need to add addresses to every stock location you create/have.

3. Add a shipping method and select the apropriated delivery method.

## To-Do

  - Write tests
  - Write docs
  - Implement package calculation

Testing
-------

Currently there are no tests!!

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

    $ bundle
    $ bundle exec rake test_app
    $ bundle exec rspec spec

Copyright (c) 2012-2015 [Locomotiva.pro](http://locomotiva.pro), released under the New BSD License
