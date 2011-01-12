module Me2day
  class Client
    include HTTParty
    base_uri "http://me2day.net/api"
    DEFAULT_FORMAT = 'xml'

    def initialize(options={})
      @app_key = options[:app_key]
      @user_id = options[:user_id]
      @user_key = options[:user_key]
      self.class.headers 'me2_application_key' => @app_key
      self.class.default_params.merge!(:uid => @user_id, :ukey => u_key(@user_key))
    end
    
    def self.get_auth_url(options={})
      raise "app_key is required" unless options[:app_key]
      self.headers 'me2_application_key' => options[:app_key]
      get("/get_auth_url.json")["url"]
    end
    
    # General helper methods

    def get(path, options={}); self.class.get(path, options).parsed_response end
    def post(path, options={}); self.class.post(path, options).parsed_response end

    # API wrappers

    def accept_friendship_request(friendship_request_id, message)
      format = options.delete(:format) || DEFAULT_FORMAT
      post("/accept_friendship_request.#{format}", 
            :query => {:friendship_request_id => friendship_request_id, :message => message})
    end

    def create_comment(post_id, body)
      format = options.delete(:format) || DEFAULT_FORMAT
      post("/create_comment.#{format}", :query => {:post_id => post_id, :body => body})
    end

    def create_post(user_id, post_body, options={})
      format = options.delete(:format) || DEFAULT_FORMAT
      post("/create_post/#{user_id}.#{format}", :query => options.merge('post[body]' => post_body))
    end
    
    def delete_comment(comment_id)
      format = options.delete(:format) || DEFAULT_FORMAT
      post("/delete_comment.#{format}", :query => {:comment_id => comment_id})
    end

    def delete_post(post_id)
      format = options.delete(:format) || DEFAULT_FORMAT
      post("/delete_post.#{format}", :query => {:post_id => post_id})
    end

    def friendship(user_id, options={})
      format = options.delete(:format) || DEFAULT_FORMAT
      scope = options.delete(:scope)
      value = options.delete(:value)
      post("/delete_post.#{format}", :query => {:user_id => user_id, :scope => scope, :value => value})
    end

    def get_bands(band_id, include_members=false)
      format = options.delete(:format) || DEFAULT_FORMAT
      get("/get_bands.#{format}", :query => {:band_id => band_id, :include_members => include_members.to_s})
    end
    
    def noop(options={})
      format = options.delete(:format) || DEFAULT_FORMAT
      get("/noop.#{format}")
    end

    def get_person(user_id)
      format = options.delete(:format) || DEFAULT_FORMAT
      get("/get_person/#{user_id}.#{format}")
    end

    
    private

    def u_key(user_key)
      nonce = rand(0xffffffff).to_s(16)
      nonce + Digest::MD5.hexdigest(nonce + user_key)
    end
    
  end
end
