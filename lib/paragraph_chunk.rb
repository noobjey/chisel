class ParagraphChunk

  attr_reader :text

  def initialize(text)
    @text = clean(text)
  end

  def render
    "<p>#{text}</p>"
  end

  def clean(text)
    text.strip
  end
end
