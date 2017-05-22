# JsonFfiClient

[![Build
Status](https://travis-ci.org/bitex-la/json-ffi-client-ruby.svg?branch=master)](https://travis-ci.org/bitex-la/json-ffi-client-ruby)

JSON-FFI is an implementation of the [jsonapi.org](http://jsonapi.org)
protocol where instead of hitting a server your client communicates
with a local shared library.

It's a way to bridge the gap between native libraries and dynamic languages.

This gem provides a Connection class for the "json_api_client" gem.
(it does not explicitly depend on "json_api_client though)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'json_ffi_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json_ffi_client

## Usage

Assuming:

- You have a library called "funky" acting as the JSON FFI server for a 'person' resource.
- You have versions of your libraries for Linux, OS X and Windows called "libfunky.so", "libfunky.dylib" and "libfunky.dll".
- All three live in live in the same directory as the file defining your JsonApiclient::Resource subclass.

```ruby
    class Person < JsonApiClient::Resource
      self.connection_class =
        JsonFfiClient::Connection.configured_for(:funky, __dir__)
    end
```

## Development

This gem could be the reference implementation for JSON FFI clients.

The JSON FFI protocol is in early stages of development.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

