require 'minitest/autorun'
require 'minitest/pride'

require './lib/renderer'
require './lib/header_chunk'

class RendererTest < Minitest::Test

  def test_render_chunks_the_input
    input    = '# My Life in Desserts'
    expected = ['# My Life in Desserts']
    renderer = Renderer.new(input)

    assert_equal expected, renderer.chunk(input)
  end

  def test_render_assigns_chunk_types
    # skip
    input    = ['# My Life in Desserts']
    renderer = Renderer.new(input)

    assigned_chunks = renderer.assign(input)

    assert "Expected Header class got: #{assigned_chunks[0].class} class", assigned_chunks[0].is_a?(HeaderChunk)
    assert_equal input[0], assigned_chunks[0].text
  end

  def test_render_ask_chunks_for_html
    # skip
    input    = HeaderChunk.new('# i am a header')
    renderer = Renderer.new(input)
    expected = "<h1>i am a header</h1>\n\n"

    html = renderer.convert_to_html(input)

    assert_equal expected, html
  end

  def test_render_input_with_one_header
    # skip
    input    = '# My Life in Desserts'
    expected = "<h1>My Life in Desserts</h1>\n\n"

    renderer = Renderer.new(input)

    assert_equal expected, renderer.rend
  end

  def test_render_input_with_multiple_chunks
    # skip

    input = <<-the_input
# My Life in Desserts

"I am a paragraph"
    the_input

    expected = <<-expected_string
<h1>My Life in Desserts</h1>

<p>
  "I am a paragraph"
</p>

    expected_string

    renderer = Renderer.new(input)

    assert_equal expected, renderer.rend
  end

  def test_render_acceptance_with_strong
    # skip
    input = <<-long_input
# My Life in Desserts

## Chapter 1: The Beginning

"You just *have* to try the cheesecake," he said. "Ever since it appeared in **Food & Wine** this place has been packed every night."

    long_input

    expected = <<-long_output
<h1>My Life in Desserts</h1>

<h2>Chapter 1: The Beginning</h2>

<p>
  "You just *have* to try the cheesecake," he said. "Ever since it appeared in <strong>Food & Wine</strong> this place has been packed every night."
</p>

    long_output

    renderer = Renderer.new(input)

    assert_equal expected, renderer.rend
  end
end
