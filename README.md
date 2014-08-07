middleman-bower
===========

[![Gem Version](http://img.shields.io/gem/v/middleman-bower.svg)][gem]
[![Code Climate](http://img.shields.io/codeclimate/github/bbtfr/middleman-bower.svg)][codeclimate]

[gem]: https://rubygems.org/gems/middleman-bower
[codeclimate]: https://codeclimate.com/github/bbtfr/middleman-bower

Bower support for Middleman projects. Dependency file is bower.json in Middleman root dir or Bowerfile if you use DSL, based on (bower-rails)[https://github.com/42dev/bower-rails].
Check out [changelog][] for the latest changes and releases.

[changelog]: https://github.com/bbtfr/middleman-bower/blob/master/CHANGELOG.md

**Requirements**

* [node](http://nodejs.org) ([on github](https://github.com/joyent/node))
* [bower](https://github.com/bower/bower) (>= 0.10.0) installed with npm

**Install**

in Gemfile

``` Ruby
  gem "middleman-bower"
```

##Middleman commands

* `middleman bower init` to create `Bowerfile`, or `middleman bower init json` to create `bower.json`

Once you are done with `bower.json` or `Bowerfile` you can run

* `middleman bower install` to install packages
* `middleman bower install deployment` to install packages from bower.json
* `middleman bower update` to update packages
* `middleman bower update prune` to update components and uninstall extraneous packages
* `middleman bower list` to list all packages
* `middleman bower clean` to remove all files not listed as [main files](#bower-main-files) (if specified)
* `middleman bower resolve` to resolve [relative asset paths](#relative-asset-paths) in components

If you'd like to pass any bower CLI options to a rake task, like `-f`, `-j`, you can simply do:

```bash
middleman bower install -f
```

##JSON configuration & Ruby DSL configuration
See (bower-rails)[https://github.com/42dev/bower-rails/blob/master/README.md#json-configuration] for detail.
