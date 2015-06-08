class ParagraphChunk

  attr_reader :text

  def initialize(text)
    @text = text
  end

  def render
    "<p>#{text}</p>"
  end
end
