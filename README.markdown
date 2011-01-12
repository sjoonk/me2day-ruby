An API client for me2day(http://me2day.net), a Twitter-like Korean popular social networking service.

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


		@client.post("/create_post/[me2_user_id]", :query => { 'post[body]' => "Hello! me2!!" })

		OR
	
		@client.create_post('me2_user_id', 'post[body]' => "Hi!, How are you!!")

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

