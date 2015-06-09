class ParagraphChunk

  attr_reader :text

  def initialize(text)
    @text = clean(text)
  end

  def render
    <<-html_with_spaces
<p>
  #{text}
</p>

    html_with_spaces
  end

  def clean(text)
    text.strip
  end
end
