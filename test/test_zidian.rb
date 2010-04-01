require "#{File.dirname(__FILE__)}/../lib/zidian"
require "test/unit"

class TestZidian < Test::Unit::TestCase

  def test_get_word_from_id
    word = Zidian.find(200)
    assert_equal(["aside", "to the side of"], word.english)
    assert_equal("一旁", word.simplified)
  end
  
  def test_get_words_from_ids
    words = Zidian.find([200, 210])
    assert_equal(["aside", "to the side of"], words.first.english)
    assert_equal(["a moment, a while", "in a moment"], words.last.english)
  end
  
  def test_raise_invalid_id
    assert_raise(Zidian::InvalidIdException) do
      Zidian.find(25)
    end
    assert_raise(Zidian::InvalidIdException) do
      Zidian.find(86618)
    end
  end
  
  def test_find_word_from_string
    words = Zidian.find("shanghai")
    assert_equal("guai3", words.last.pinyin)
  end
  
  def test_raise_when_invalid_input_type
    assert_raise(Zidian::InvalFindInputException) do
      Zidian.find(:shanghai)
    end
  end
  
  def test_word_proper_extraction
    word = Zidian::Word.new("134:一夫當關，萬夫莫開 一夫当关，万夫莫开 [yi1 fu1 dang1 guan1 , wan4 fu1 mo4 kai1] /If one man holds the pass, ten thousand cannot pass (idiom); One man can hold the pass against ten thousand enemies/\n")
    assert_equal(134, word.id)
    assert_equal("一夫當關，萬夫莫開", word.traditional)
    assert_equal("一夫当关，万夫莫开", word.simplified)
    assert_equal("yi1 fu1 dang1 guan1 , wan4 fu1 mo4 kai1", word.pinyin)
    assert_equal(["If one man holds the pass, ten thousand cannot pass (idiom); One man can hold the pass against ten thousand enemies"], word.english)
  end

end