require File.join(File.dirname(__FILE__), "/test_helper")

class ClientTest < Test::Unit::TestCase
  include Me2day
  
  context "get_auth_url" do
    setup do
      FakeWeb.register_uri(:get, 
        'http://me2day.net/api/get_auth_url.json', 
        :body => "#{FIXTURES_DIR}/get_auth_url.json", 
        :content_type => "text/json")
    end
  
    should "require a app_key" do
      lambda { Client.get_auth_url }.should raise_error
      Client.get_auth_url(:app_key => 'YOUR_ME2DAY_APPLICATION_KEY').should == "http://me2day.net/api/start_auth?token=2d76abbbca0db990d17fd5e84227041e"
    end
  end

  context "Calling api" do
    setup do 
      @client = Client.new(
        :user_id => "tester",
        :user_key => "nonce_plus_md5_hash",
        :app_key => "YOUR_ME2DAY_APPLICATION_KEY"
      )
    end

    context "noop" do
      setup do
        FakeWeb.register_uri(:get, %r|http://me2day\.net/api/noop.json|, 
          :body => "#{FIXTURES_DIR}/noop.json", :content_type => "text/json")
      end

      should "return valid response code" do
        @client.noop["code"].should == 0
      end
    end

    context "create_post" do
      setup do
        FakeWeb.register_uri(:get, %r|http://me2day\.net/api/create_post/sjoonk.json|, 
          :body => "#{FIXTURES_DIR}/create_post.json", :content_type => "text/json")
      end

      should "return valid response" do
        post = @client.create_post("sjoonk", :'post[body]' => 'blablabla')
        post['body'].should == 'blablabla'
      end
    end


  end
  
end
