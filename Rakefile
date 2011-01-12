require 'rubygems'
require 'rake'
require 'echoe'
require 'shoulda/tasks'

task :default => ["test:units"]

desc "Run basic tests"
Rake::TestTask.new("test:units") { |t|
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
  t.warning = true
}

Echoe.new('me2day-ruby', '0.1.0') do |p|
  p.description    = "a me2day API client"
  p.url            = "https://github.com/sjoonk/me2day-ruby"
  p.author         = "Sukjoon Kim"
  p.email          = "sjoonk@gmail.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = ['httparty']
end
