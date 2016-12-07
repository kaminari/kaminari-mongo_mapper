# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kaminari/mongo_mapper/version'

Gem::Specification.new do |spec|
  spec.name          = "kaminari-mongo_mapper"
  spec.version       = Kaminari::MongoMapper::VERSION
  spec.authors       = ["Akira Matsuda"]
  spec.email         = ["ronnie@dio.jp"]

  spec.summary       = 'Kaminari MongoMapper adapter'
  spec.description   = 'kaminari-mongo_mapper lets your MongoMapper models be paginatable'
  spec.homepage      = 'https://github.com/kaminari/kaminari-mongo_mapper'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'kaminari-core'
  spec.add_dependency 'mongo_mapper'

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rails'
  spec.add_development_dependency 'test-unit-rails'
  spec.add_development_dependency 'capybara'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'rr'
end
