SpreeCorreiosShipping
=====================

This is a gem to allow use Correios service for shipping methods in spree


Example
=======

You will need setup some confs in your app

```ruby
Spree::CorreiosShipping::Config[:origin_zip_code] = '00122000'
Spree::CorreiosShipping::Config[:id_correios] = '1234123'
Spree::CorreiosShipping::Config[:password_correios] = 'abcabcabc'
```

Example goes here.

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

    $ bundle
    $ bundle exec rake test_app
    $ bundle exec rspec spec

Copyright (c) 2012 Denis Antoniazzi, released under the New BSD License
