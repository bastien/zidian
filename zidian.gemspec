# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{zidian}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bastien Vaucher"]
  s.date = %q{2010-03-31}
  s.description = %q{Chinese dictionary written in ruby}
  s.email = %q{bastien.vaucher@gmail.com}
  s.extra_rdoc_files = ["lib/zidian.rb"]
  s.files = ["README.mkd", "Rakefile", "lib/cedict_ts.u8", "lib/zidian.rb", "Manifest", "zidian.gemspec"]
  s.homepage = %q{http://github.com/bastien/zidian}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Zidian", "--main", "README.mkd"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{zidian}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Chinese dictionary}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
