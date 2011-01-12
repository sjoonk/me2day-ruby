require File.join(File.dirname(__FILE__), "/test_helper")

class ClientTest < Test::Unit::TestCase
  include Me2day

  context "A client instance" do

    setup do
      @client = Client.new
    end

    should "be kind of Me2day client" do
      assert_kind_of Me2day::Client, @client
    end
    
  end  
  
end
