# Complicode

[![Gem](https://img.shields.io/gem/v/complicode.svg?style=flat)](http://rubygems.org/gems/complicode)
[![CircleCI](https://circleci.com/gh/pablocrivella/complicode.svg?style=svg)](https://circleci.com/gh/pablocrivella/complicode)
[![Maintainability](https://api.codeclimate.com/v1/badges/935822c7c481aa464186/maintainability)](https://codeclimate.com/github/pablocrivella/complicode/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/935822c7c481aa464186/test_coverage)](https://codeclimate.com/github/pablocrivella/complicode/test_coverage)

Control code generator for invoices inside the Bolivian national tax service..

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
Complicode::Generate.call(authorization_code, key, number: "1503", nit: "4189179011", issue_date: "20070702", amount: "2500")
# => "6A-DC-53-05-14"
# If ignored, "nit" defaults to "0"
Complicode::Generate.call(authorization_code, key, number: "1503", issue_date: "20070702", amount: "2500")
# => "9E-84-73-A4"
```

## Tests

To test, run:

```
bundle exec rspec spec/
```

## Versioning

Read [Semantic Versioning](https://semver.org) for details. Briefly, it means:

- Major (X.y.z) - Incremented for any backwards incompatible public API changes.
- Minor (x.Y.z) - Incremented for new, backwards compatible, public API enhancements/fixes.
- Patch (x.y.Z) - Incremented for small, backwards compatible, bug fixes.

## License

Copyright 2018 [Pablo Crivella](https://pablocrivella.me).
Read [LICENSE](LICENSE.md) for details.
