module Me2day
  class Client
    include HTTParty
    base_uri "http://me2day.net/api"
    DEFAULT_FORMAT = 'json'
    @@apis = %w(
      accept_friendship_request
      create_comment
      create_post
      delete_comment
      delete_post
      friendship
      get_bands
      get_comments
      get_friends
      get_friendship_requests
      get_latests 
      get_metoos
      get_person
      get_posts
      get_settings
      metoo
      noop
      track_comments
    )

    class UnauthenticatedError < RuntimeError; end
    class InternalServerError < RuntimeError; end

    class << self
      # attr_accessor :app_key

      def get_auth_url(options={})
        raise "app_key is required" unless options[:app_key]
        self.headers 'me2_application_key' => options[:app_key]
        @auth_url ||= get("/get_auth_url.json")["url"]
      end
    end

    def initialize(options={})
      @app_key = options[:app_key]
      @user_id = options[:user_id]
      @user_key = options[:user_key]
      @auth = { :uid => @user_id, :ukey => u_key(@user_key) }
      self.class.headers 'me2_application_key' => @app_key
    end
    
    def method_missing(method_sym, *args, &block)
      if @@apis.include?(method_sym.to_s)
        id_part = args.first.is_a?(String) ? "/#{args.first}" : ''
        options = args.last.is_a?(Hash) ? args.last : {}
        format = options ? (options.delete(:format) || DEFAULT_FORMAT) : DEFAULT_FORMAT
        options.merge!(@auth)
        resp = self.class.get("/#{method_sym}#{id_part}.#{format}", :query => options)
        case resp.response.code.to_s
          when "200"
            resp
          when "401"
            raise UnauthenticatedError, resp.parsed_response.to_s  
          when "500"
            raise InternalServerError, resp.parsed_response.to_s
          else
            raise "Unknown Error", resp.inspect
          end       
      else    
        super
      end
    end

    # General helper methods (deprecated)

    def get(path, options={}); self.class.get(path, options).parsed_response end
    def post(path, options={}); self.class.post(path, options).parsed_response end

    private

    def u_key(user_key)
      nonce = rand(0xffffffff).to_s(16)
      nonce + Digest::MD5.hexdigest(nonce + user_key)
    end
    
  end
end
