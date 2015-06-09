require 'minitest/autorun'
require 'minitest/pride'
require './lib/strikethrough_chunk'

class StrikethroughChunkTest < Minitest::Test

  def test_has_original_input
    input = "some string"
    chunk = StrikethroughChunk.new(input)

    assert_equal input, chunk.text
  end

  def test_renders_strikethrough_html
    input = "~~some string~~"
    chunk = StrikethroughChunk.new(input)

    assert_equal "<del>some string</del>", chunk.render
  end
end
