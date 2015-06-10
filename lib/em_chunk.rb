class EmChunk
  attr_reader :text

  def initialize(input)
    @text = input
  end

  def render
    result = text
    while contains_em_markdown?(result)
      result = result.sub('*', '<em>')
      result = result.sub('*', '</em>')
    end
    result
  end

  def contains_em_markdown?(input)
    input.include?('*')
  end
end
