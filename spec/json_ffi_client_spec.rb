require "spec_helper"
require "json_api_client"

describe JsonFfiClient do
  it "has a version number" do
    expect(JsonFfiClient::VERSION).not_to be nil
  end

  it "Calls an existing create method" do
    class Base < JsonApiClient::Resource
      self.connection_class = JsonFfiClient::Connection
        .configured_for(:bureaucrat, File.join(__dir__, "fixtures"))
    end
    class Cbu < Base; end

    cbu = Cbu.create(id: "foo")
    cbu.errors[:base].should == ['InvalidCbuFormat']

    cbu = Cbu.create(id: "0170035040000002373188")
    cbu.errors.should be_empty
    
    cbu.attributes.should == {
      "id"=>"0170035040000002373188",
      "type"=>"cbus",
      "meta"=>nil,
      "bank"=>"017",
      "branch"=>"0035",
      "bank_name"=>"BBVA Banco Francés S.A.",
      "account"=>"40000002373188"
    }
  end

  it "raises if dynamic library is not found" do
    expect do
      class Base < JsonApiClient::Resource
        self.connection_class = JsonFfiClient::Connection
          .configured_for(:bureaucrat, "bogusdir")
      end
    end.to raise_exception(JsonFfiClient::Error)
  end
end
