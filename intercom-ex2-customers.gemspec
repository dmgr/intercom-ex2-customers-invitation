# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'intercom/ex2/version'

Gem::Specification.new do |spec|
  spec.name          = "intercom-ex2-customers-invitation"
  spec.version       = Intercom::Ex2::VERSION
  spec.authors       = ["Dawid Marcin Grzesiak"]
  spec.email         = ["dawid@grzesiak.pro"]
  spec.summary       = %q{A program that will read the full list of customers from STDIN and output the names and user ids of matching customers (within radius), sorted by user id (ascending).}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = Dir['Rakefile', '{bin,lib,man,test,spec,fixtures}/**/*', 'README*', 'LICENSE*'] # & `git ls-files -z`.split("\0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  spec.add_dependency "slop", "~> 4.2.1"
  spec.add_dependency "unindent"
end
