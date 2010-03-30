module Zidian
  
  def self.find(expression)
    $KCODE = 'UTF8'
    case expression.class.name
    when "Integer", "Fixnum" then
      line = `sed -n '#{expression}p' lib/cedict_ts.u8`
      extract(line, expression)
    when "String" then
      lines = `less lib/cedict_ts.u8 | grep -n '[/\s]#{expression.gsub(/\s/,"\s")}[/\s]'` 
      # adding the -i option allows to search independently from the case, but it makes it very slow
      lines.lines.to_a.collect{|line| extract(line) }
    else
      raise "Invalid find parameter(#{expression.class}). Only integers, strings accepted"
    end
  end
  
  protected
  
  def self.extract(line, line_number = nil)
    line.strip!
    if line =~ /^[0-9]*:/
      line_number = line.gsub!(/^[0-9]*:/).to_a.first.gsub(':','').to_i
    end
    {
      :id => line_number,
      :traditional => line.match(/^[^\s]+/)[0],
      :simplified => line.match(/\s[^\s]+/)[0].strip,
      :pinyin  => line.match(/\[.+?\]/)[0].gsub(/[\[\]]/,''),
      :english => line.scan(/\/[^\/]+/).collect{|e| e.gsub(/[\/]/,'')}
    }
  end
  
end