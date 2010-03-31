module Zidian
  
  def self.find(expression)
    $KCODE = 'UTF8'
    case expression.class.name
    when "Array"
      expression.collect{|e| find(e) }.flatten.uniq
    when "Integer", "Fixnum" then
      Word.new(get_line(expression), expression)
    when "String" then
      find_word(expression).lines.to_a.collect{|line| Word.new(line) }
    else
      raise "Invalid find parameter(#{expression.class}). Only integers, strings accepted"
    end
  end
  
  protected
  
  def self.find_word(word) #:nodoc:
    # adding the -i option allows to search independently from the case, but it makes it very slow
    `less #{File.dirname(__FILE__)}/cedict_ts.u8 | grep -n '[/\s]#{word.gsub(/\s/,"\s")}[/\s]'`
  end
  
  def self.get_line(line_number) #:nodoc:
    `sed -n '#{line_number}p' #{File.dirname(__FILE__)}/cedict_ts.u8`
  end
  
  class Word
    
    attr_reader :id, :traditional, :simplified, :pinyin, :english
    
    def initialize(line, id=nil)
      @id = id
      extract_attributes_from_string(line.strip!)
    end
    
    def extract_attributes_from_string(line)
      if line =~ /^[0-9]*:/
        @id = line.gsub!(/^[0-9]*:/).to_a.first.gsub(':','').to_i
      end
      @traditional = line.match(/^[^\s]+/)[0]
      @simplified = line.match(/\s[^\s]+/)[0].strip
      @pinyin  = line.match(/\[.+?\]/)[0].gsub(/[\[\]]/,'')
      @english = line.scan(/\/[^\/]+/).collect{|e| e.gsub(/[\/]/,'')}
    end
    
  end
  
end