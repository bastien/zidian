# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'
require 'rake/rdoctask'
  
require 'jeweler'
  
Jeweler::Tasks.new do |gemspec|  
    gemspec.name = "zidian"  
    gemspec.summary = "Chinese dictionary"  
    gemspec.description = "Chinese dictionary using the CEDICT word list"  
    gemspec.email = "bastien.vaucher@gmail.com"  
    gemspec.homepage = "http://github.com/bastien/zidian"  
    gemspec.authors = ["Bastien Vaucher"]  
end 
Jeweler::GemcutterTasks.new 

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test

desc 'Generate documentation for the Zidian gem.'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Zidian'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.mkd')
  rdoc.rdoc_files.include('lib/**/*.rb')
end