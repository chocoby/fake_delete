# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fake_delete/version'

Gem::Specification.new do |spec|
  spec.name          = "fake_delete"
  spec.version       = FakeDelete::VERSION
  spec.authors       = ["chocoby"]
  spec.email         = ["chocoby@gmail.com"]
  spec.description   = %q{"Soft-delete" gem for Rails. It can enable the unique constraint by database.}
  spec.summary       = %q{"Soft-delete" gem for Rails. It can enable the unique constraint by database.}
  spec.homepage      = "https://github.com/chocoby/fake_delete"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "activerecord", ">= 3.2.6"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "database_cleaner"
  spec.add_development_dependency "awesome_print"
end
