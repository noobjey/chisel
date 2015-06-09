class StrikethroughChunk
  attr_accessor :text

  def initialize(text)
    @text = text
  end

  def render
    "<del>#{remove_markdown(text)}</del>"
  end

  private

  def remove_markdown(text)
    text.delete('~~')
  end
end
