# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{me2day-ruby}
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sukjoon Kim"]
  s.date = %q{2011-01-22}
  s.description = %q{a me2day API client}
  s.email = %q{sjoonk@gmail.com}
  s.extra_rdoc_files = ["LICENSE", "README.markdown", "lib/me2day.rb", "lib/me2day/client.rb"]
  s.files = ["LICENSE", "README.markdown", "Rakefile", "lib/me2day.rb", "lib/me2day/client.rb", "test/client_test.rb", "test/test_helper.rb", "Manifest", "me2day-ruby.gemspec"]
  s.homepage = %q{https://github.com/sjoonk/me2day-ruby}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Me2day-ruby", "--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{me2day-ruby}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{a me2day API client}
  s.test_files = ["test/client_test.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<httparty>, [">= 0"])
    else
      s.add_dependency(%q<httparty>, [">= 0"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0"])
  end
end
