require 'minitest/autorun'
require 'minitest/pride'
require './lib/renderer'

class RendererTest < Minitest::Test

  def test_render_chunks_the_input
    input    = '# My Life in Desserts'
    expected = '<h1>My Life in Dessert</h1>'

    renderer = Renderer.new(input)

    assert_equal expected, renderer.chunk
  end

  def test_render_input_with_one_header
    skip
    input    = '# My Life in Desserts'
    expected = '<h1>My Life in Dessert</h1>'

    renderer = Renderer.new(input)

    assert_equal expected, renderer.rend
  end

  def test_render_acceptance
    skip
    input = <<-long_input
# My Life in Desserts

## Chapter 1: The Beginning

"You just *have* to try the cheesecake," he said. "Ever since it appeared in **Food & Wine** this place has been packed every night."

    long_input

    expected = <<-long_output
<h1>My Life in Desserts</h1>

<h2>Chapter 1: The Beginning</h2>

<p>
"You just <em>have</em> to try the cheesecake," he said. "Ever since it appeared in <strong>Food &amp; Wine</strong> this place has been packed every night."
 </p>
    long_output

    renderer = Renderer.new(input)

    assert_equal expected, renderer.rend
  end
end
