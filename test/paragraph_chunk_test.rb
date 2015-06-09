require 'minitest/autorun'
require 'minitest/pride'
require './lib/paragraph_chunk'

class ParagraphChunkTest < Minitest::Test

  def test_it_removes_newlines
    chunk = ParagraphChunk.new("wowowow\n")
    expected = 'wowowow'
    assert_equal expected, chunk.text
  end

  def test_it_can_render_an_HTML_paragraph_with_newlines
    chunk = ParagraphChunk.new('wowowow')
    expected = <<-expected_html
<p>
  wowowow
</p>

    expected_html

    assert_equal expected, chunk.render
  end

end
