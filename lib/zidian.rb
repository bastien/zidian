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
      raise InvalFindInputException
    end
  end
  
  protected
  
  def self.find_word(word) #:nodoc:
    # adding the -i option allows to search independently from the case, but it makes it very slow
    `less #{File.dirname(__FILE__)}/cedict_ts.u8 | grep -n '[/\s]#{word.gsub(/\s/,"\s")}[/\s]'`
  end
  
  def self.get_line(line_number) #:nodoc:
    raise InvalidIdException if (line_number < 35 || line_number > 86617)
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
  
  class InvalidIdException < Exception; 
    def message
      "Invalid ID, must be between 35 and 86617"
    end
  end
  
  class InvalFindInputException < Exception; 
    def message
      "Invalid find parameter. Only integers, strings accepted"
    end
  end
  
end