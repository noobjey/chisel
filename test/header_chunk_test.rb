require 'minitest/autorun'
require 'minitest/pride'
require './lib/header_chunk'

class HeaderChunkTest < Minitest::Test

  def test_it_has_text_method
    chunk = HeaderChunk.new('some crap')

    assert_respond_to chunk, :text
  end

  def test_it_has_render_method
    chunk = HeaderChunk.new('some crap')

    assert_respond_to chunk, :render
  end

  def test_it_detects_a_header_level_of_one
    chunk = HeaderChunk.new('# some crap')
    assert_equal(1, chunk.header_level)
  end

  def test_it_detects_a_header_level_of_two
    chunk = HeaderChunk.new('## some crap')
    assert_equal(2, chunk.header_level)
  end

  def test_it_renders_an_h1
    chunk = HeaderChunk.new('# some crap')
    expected = '<h1>some crap</h1>'

    assert_equal(expected, chunk.render)
  end

  def test_it_renders_an_h2
    chunk = HeaderChunk.new('## some crap')
    expected = '<h2>some crap</h2>'

    assert_equal(expected, chunk.render)
  end

end
