require "json_ffi_client/version"
require "json"
require "ffi"

module JsonFfiClient
  class Response < FFI::AutoPointer
    def self.release(ptr)
      Connection.free(ptr)
    end

    def body
      @body ||= JSON.parse(self.read_string).delete_if{|k,v| v.nil?}
    end
    
    def env
      {}
    end
  end

  class Connection
    extend FFI::Library
    def initialize(*args); end

    def self.configured_for(library_name, base_path)
      @@library_name = library_name

      lib_ext = if(FFI::Platform.mac?)
        "dylib"
      elsif(FFI::Platform.windows?)
        "dll"
      else
        "so"
      end

      begin 
        ffi_lib File.join(base_path, "lib#{library_name}.#{lib_ext}")
      rescue LoadError => e
        raise Error
          .new("#{e.message}. Maybe '#{RUBY_PLATFORM}' is not supported.")
      end

      attach_function :free, "#{library_name}_free".to_sym, [Response], :void
      self
    end
    
    def self.method_missing(message, *args, &blk)
      attach_function message, message, [:string], Response
      send(message, *args)
    end
    
    def run(method, path, params = {}, headers = {})
      raise JsonFfiError.new("Connection not configured") unless @@library_name
      self.class.send([@@library_name, method, path].join("_"), params.to_json)
    end
  end

  class Error < StandardError; end
end
