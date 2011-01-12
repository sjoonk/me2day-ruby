An API client for me2day(http://me2day.net), a twitter-like popular Korean social networking service.

Install
=====

$ (sudo) gem install me2day-ruby


me2day "Easy Authentication (Web-based)"
=====

	require 'me2day'
	
	@auth_url = Me2day::Client.get_auth_url(:app_key => "YOUR_ME2DAY_APPLICATION_KEY")
	=> "http://me2day.net/api/start_auth?token=XXXXXXXXXXXXXX"

.. then redirection to the auth_url
.. and then user accept the auth
.. and then in callback

	token, user_id, user_key, result = request.params["token"], request.params["user_id"], request.params["user_key"], request.params["result"]

	if result == 'true'

		@client = Me2day::Client.new(
			:user_id => user_id,
			:user_key => user_key,
			:app_key => "YOUR_ME2DAY_APPLICATION_KEY"
		)

		@client.get("/noop")
		=> {"error"=>{"code"=>"0", "description"=>nil, "message"=>"\354\204\261\352\263\265\355\226\210\354\212\265\353\213\210\353\213\244."}}

		OR 
		
		@client.noop
		=> {"error"=>{"code"=>"0", "description"=>nil, "message"=>"\354\204\261\352\263\265\355\226\210\354\212\265\353\213\210\353\213\244."}}

		OR

		client.noop(:format => 'json')
		=> {"code"=>1007, "description"=>"\354\225\224\355\230\270\352\260\200 \354\235\274\354\271\230\355\225\230\354\247\200 \354\225\212\354\212\265\353\213\210\353\213\244.", "message"=>"\354\235\270\354\246\235 \354\213\244\355\214\250"}

		@client.post("/create_post/[me2_user_id]", :query => { 'post[body]' => "Hello! me2!!" })

		OR
	
		@client.create_post('me2_user_id', "Hi!, How are you!!")

	end


Todos
=====

	* Add more methods
	* Error Handling
	* DRY cleaning!


Dependencies
=====

	* httparty (https://github.com/jnunemaker/httparty)


References
=====

	* http://codian.springnote.com/pages/1645274
	* http://codian.springnote.com/pages/89009
	* http://thinkr.egloos.com/2584593

