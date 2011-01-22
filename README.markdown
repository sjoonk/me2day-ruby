An API client for me2day(http://me2day.net), a twitter-like popular Korean social networking service.

설치(Installation)
=====

$ (sudo) gem install me2day-ruby


기본 사용법(Basic Usage)
=====

우선 클라이언트를 생성합니다. 이 때 app_key, user_id, user_key가 필요합니다.
app_key는 미투데이로부터 부여받은 APPLICATION_KEY이며, user_id와 user_key는 인증을 통해 획득할 수 있습니다.

	require 'me2day'

	@client = Me2day::Client.new(
		:user_id => user_id,
		:user_key => user_key,
		:app_key => "YOUR_ME2DAY_APPLICATION_KEY"
	)

생성된 클라이언트에 대해 메서드를 호출합니다.
미투데이 사용설명서에 있는 모든 메서드를 호출할 수 있으며, 모든 파라미터를 이름 그래도 사용하면 됩니다. 
자세한 사용법은 미투데이 사용설명서를 참고하시면 됩니다.

	@client.noop
	@client.create_post "me2_id", 'post[body]' => "안녕하세요, 미투데이!"
	@client.get_comments :post_id => '123456'
	@client.get_person "me2_id"
	@client.get_friends "me2_id"


웹 기반 쉬운 인증
=====

미투데이는 웹 기반 쉬운 인증이라는 자체 인증방식을 제공하며, 이 방법을 사용하면 사용자의 user_id와 user_key를 쉽게 얻을 수 있습니다.

1) 인증 URL을 얻습니다.

	auth_url = Me2day::Client.get_auth_url(:app_key => "YOUR_ME2DAY_APPLICATION_KEY")
	=> "http://me2day.net/api/start_auth?token=XXXXXXXXXXXXXX"

2)  위 auth_url로 리다이렉션(redirect) 합니다.	

3) 설정한 콜백(callback)에서 다음과 같이 처리 합니다.

	token, user_id, user_key, result = request.params["token"], request.params["user_id"], request.params["user_key"], request.params["result"]

	if result == 'true'

		@client = Me2day::Client.new(
			:user_id => user_id,
			:user_key => user_key,
			:app_key => "YOUR_ME2DAY_APPLICATION_KEY"
		)

		@client.noop
		=> {"error"=>{"code"=>"0", "description"=>nil, "message"=>"\354\204\261\352\263\265\355\226\210\354\212\265\353\213\210\353\213\244."}}

		@client.create_post 'me2_id', "오늘의 미친 짓!"

	end


Todos
=====

	* Enhancing error handling
	* Add more tests
	* DRY cleaning!


Dependencies
=====

	* httparty (https://github.com/jnunemaker/httparty)


References
=====

	* http://codian.springnote.com/pages/1645274
	* http://codian.springnote.com/pages/89009
	* http://thinkr.egloos.com/2584593

