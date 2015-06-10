class EmChunk
  attr_reader :text

  def initialize(input)
    @text = input
  end

  def render
    opening_markdown_replaced = text.sub('*', '<em>')
    opening_markdown_replaced.sub('*', '</em>')
  end

  def contains_em_markdown?
    text.include?('*')
  end
end
