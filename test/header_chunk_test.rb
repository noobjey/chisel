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
    expected = "<h1>some crap</h1>\n\n"

    assert_equal(expected, chunk.render)
  end

  def test_it_renders_an_h2
    chunk = HeaderChunk.new('## some crap')
    expected = "<h2>some crap</h2>\n\n"

    assert_equal(expected, chunk.render)
  end

  def test_it_renders_an_h5
    chunk = HeaderChunk.new('##### some crap')
    expected = "<h5>some crap</h5>\n\n"

    assert_equal(expected, chunk.render)
  end

  def test_it_removes_blank_space_after_header_markdown
    chunk = HeaderChunk.new('# some crap')
    expected = "<h1>some crap</h1>\n\n"

    assert_equal(expected, chunk.render)
  end

  def test_it_removes_newline
    chunk = HeaderChunk.new("# some crap\n\n")
    expected = "# some crap"

    assert_equal(expected, chunk.text)

  end

  def test_it_adds_two_newlines
    chunk = HeaderChunk.new('##### some crap')

    expected = <<-html_with_spaces
<h5>some crap</h5>

    html_with_spaces

    assert_equal(expected, chunk.render)
  end
end
