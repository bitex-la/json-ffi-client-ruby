# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'json_ffi_client/version'

Gem::Specification.new do |spec|
  spec.name          = "json_ffi_client"
  spec.version       = JsonFfiClient::VERSION
  spec.authors       = ["nubis"]
  spec.email         = ["nb@bitex.la"]

  spec.summary       = "Build ruby JSON-FFI clients using ffi & json_api_client"
  spec.homepage      = "https://github.com/bitex-la/json_ffi_client"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "ffi", "~> 1.9"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "json_api_client", "~> 1.5"
  spec.add_development_dependency "byebug", "~> 9.0"
end
