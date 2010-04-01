require 'rubygems'  
require 'rake'  
  
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
  
Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }