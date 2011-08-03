module Zidian
  
  def self.find(expression)
    $KCODE = 'UTF8' if RUBY_VERSION < "1.9.0"
    case expression.class.name
    when "Array"
      expression.collect{|e| find(e) }.flatten.uniq
    when "Integer", "Fixnum" then
      Word.new(get_line(expression), expression)
    when "String" then
      find_words(expression).collect{|raw_word| Word.new(raw_word) }
    else
      raise InvalFindInputException
    end
  end
  
  protected
  
  def self.find_words(word, case_sensitive = false) #:nodoc:
    words = word.split.map{|w| "#{w}[1-4]?"}.join(" ")
    # adding the -i option allows to search independently from the case, but it makes it very slow
    results = `less #{File.dirname(__FILE__)}/cedict_ts.u8 | grep -n -E#{ case_sensitive ? ' -i' : ''} '(^|[^a-zA-Z])#{words}($|[^a-zA-Z])'`
    sort_lines(results.lines.to_a, words)
  end
  
  def self.get_line(line_number) #:nodoc:
    raise InvalidIdException if (line_number < 35 || line_number > 86617)
    `sed -n '#{line_number}p' #{File.dirname(__FILE__)}/cedict_ts.u8`
  end
  
  # Sorts the lines by similarity to the words
  #
  def self.sort_lines(lines, words)
    lines.sort do |a, b|
      line_similarity_to_words(a, words) <=> line_similarity_to_words(b, words)
    end
  end
  
  def self.line_similarity_to_words(line, words)
    # words delimited by : ],:/[
    # Very basic similarity determination
    # we count how many characters before and after the word, the less characters the more similar the match is
    match_data = line.match("(^|[,:\\\[\/,])([^\\\[\/,:]*)#{words}([^\\\]\\\[\/,]*)($|[,\\\]\\\[\/,])").to_a
    match_data[2].strip.size + match_data[3].strip.size
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