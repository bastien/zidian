require 'rubygems'  
require 'rake'
require 'rake/rdoctask'
  
begin  
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
rescue LoadError  
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"  
end  

desc 'Generate documentation for the Zidian gem.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Zidian'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.mkd')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }