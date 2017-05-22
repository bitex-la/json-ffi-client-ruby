$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "json_ffi_client"
RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:expect, :should]
  end
end
