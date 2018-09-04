# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "complicode/version"

Gem::Specification.new do |spec|
  spec.name          = "complicode"
  spec.version       = Complicode::VERSION
  spec.authors       = ["Pablo Crivella"]
  spec.email         = ["pablocrivella@gmail.com"]
  spec.summary       = "Complicode! A needlessly complicated code generator!"
  spec.description   = "Control code generator for invoices inside the Bolivian national tax service."
  spec.homepage      = "https://github.com/mobile-bits/complicode-ruby"
  spec.license       = "MIT"
  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/pablocrivella/complicode/issues",
    "changelog_uri"   => "https://github.com/pablocrivella/complicode/blob/master/CHANGELOG.md",
    "source_code_uri" => "https://github.com/pablocrivella/complicode"
  }
  spec.files = Dir["lib/**/*"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.require_paths = ["lib"]

  spec.add_dependency "radix", "~> 2.2"
  spec.add_dependency "ruby-rc4", "~> 0.1.5"
  spec.add_dependency "verhoeff", "~> 2.1"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "pry", "~> 0.11"
  spec.add_development_dependency "pry-byebug", "~> 3.6"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec_junit_formatter", "~> 0.4"
  spec.add_development_dependency "rubocop", "~> 0.58"
  spec.add_development_dependency "rubocop-rspec", "~> 1.29"
  spec.add_development_dependency "simplecov", "~> 0.16"
  spec.add_development_dependency "smarter_csv", "~> 1.2"
end
