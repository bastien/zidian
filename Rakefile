require 'rubygems'  
require 'rake'  
require 'echoe'  
  
Echoe.new('zidian', '0.0.1') do |p|  
  p.description     = "Chinese dictionnary"  
  p.url             = "http://github.com/bastien/zidian"  
  p.author          = "Bastien Vaucher"  
  p.email           = "bastien.vaucher@gmail.com"  
  p.ignore_pattern  = ["tmp/*", "script/*"]  
  p.development_dependencies = []  
end  
  
Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }