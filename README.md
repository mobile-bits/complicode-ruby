# Complicode

[![Gem](https://img.shields.io/gem/v/complicode.svg?style=flat)](http://rubygems.org/gems/complicode)
[![Depfu](https://badges.depfu.com/badges/6f2f73672eae4d603d6ae923164435e2/overview.svg)](https://depfu.com/github/pablocrivella/statics?project=Bundler)
[![Inline docs](http://inch-ci.org/github/pablocrivella/complicode.svg?branch=master&style=shields)](http://inch-ci.org/github/pablocrivella/complicode)
[![CircleCI](https://circleci.com/gh/pablocrivella/complicode.svg?style=svg)](https://circleci.com/gh/pablocrivella/complicode)
[![Maintainability](https://api.codeclimate.com/v1/badges/d874a9673862541f247b/maintainability)](https://codeclimate.com/github/pablocrivella/complicode/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/d874a9673862541f247b/test_coverage)](https://codeclimate.com/github/pablocrivella/complicode/test_coverage)

Control code generator for invoices inside the Bolivian national tax service.

Links:

  - [API Docs](https://www.rubydoc.info/gems/complicode)
  - [Contributing](https://github.com/pablocrivella/complicode/blob/master/CONTRIBUTING.md)
  - [Code of Conduct](https://github.com/pablocrivella/complicode/blob/master/CODE_OF_CONDUCT.md)

## Requirements

1. [Ruby 2.5.0](https://www.ruby-lang.org)

## Installation

To install, run:

```
gem install complicode
```

Or add the following to your Gemfile:

```
gem "complicode"
```

## Usage

```ruby
require "complicode"

authorization_code = "29040011007"
key = "9rCB7Sv4X29d)5k7N%3ab89p-3(5[A"
invoice = Complicode::Invoice.new(number: 1503, nit: 4189179011, issue_date: Date.new(2007, 7, 2), amount: 2500.0)
generator = Complicode::Generator.new
generator.call(authorization_code: authorization_code, key: key, invoice: invoice)
# => "6A-DC-53-05-14"
```

## Tests

To test, run:

```shell
bundle exec rspec spec/
```

## Versioning

Read [Semantic Versioning](https://semver.org) for details. Briefly, it means:

- Major (X.y.z) - Incremented for any backwards incompatible public API changes.
- Minor (x.Y.z) - Incremented for new, backwards compatible, public API enhancements/fixes.
- Patch (x.y.Z) - Incremented for small, backwards compatible, bug fixes.

## License

Copyright 2020 [Pablo Crivella](https://pablocrivella.me).
Read [LICENSE](LICENSE) for details.
