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

    assert_equal expected, renderer.render
  end

  def test_render_input_with_nested_inlines
    # skip
    input    = '# My *Life **in** Desserts*'
    expected = "<h1>My <em>Life <strong>in</strong> Desserts</em></h1>\n\n"

    renderer = Renderer.new(input)

    assert_equal expected, renderer.render
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

    assert_equal expected, renderer.render
  end

  def test_render_list_with_inline_markdown
    # skip
    input = <<-long_input
* *Sushi*
* **Barbeque**
* Mexican

1. **Sushi**
2. *Barbeque*
3. Mexican

    long_input

    expected = <<-long_output
<ul>
  <li><em>Sushi</em></li>
<li><strong>Barbeque</strong></li>
<li>Mexican</li>
</ul>

<ol>
  <li><strong>Sushi</strong></li>
<li><em>Barbeque</em></li>
<li>Mexican</li>
</ol>

    long_output

    renderer = Renderer.new(input)

    assert_equal expected, renderer.render
  end


  def test_render_acceptance_with_list_with_title
    # skip
    input = <<-long_input
# My Life in Desserts

## Chapter 1: The Beginning

"You just *have* to try the cheesecake," he said. "Ever since it appeared in **Food & Wine** this place has been packed every night."

My favorite [cuisines](http://cuisine.com/ "Title") are:

* Sushi
* Barbeque
* Mexican

My favorite cuisines are:

1. Sushi
2. [Barbeque](http://barbeque.com/)
3. Mexican

    long_input

    expected = <<-long_output
<h1>My Life in Desserts</h1>

<h2>Chapter 1: The Beginning</h2>

<p>
  "You just <em>have</em> to try the cheesecake," he said. "Ever since it appeared in <strong>Food & Wine</strong> this place has been packed every night."
</p>

<p>
  My favorite <a href="http://cuisine.com/" title="Title">cuisines</a> are:
</p>

<ul>
  <li>Sushi</li>
<li>Barbeque</li>
<li>Mexican</li>
</ul>

<p>
  My favorite cuisines are:
</p>

<ol>
  <li>Sushi</li>
<li><a href="http://barbeque.com/">Barbeque</a></li>
<li>Mexican</li>
</ol>

    long_output

    renderer = Renderer.new(input)

    assert_equal expected, renderer.render
  end
end
