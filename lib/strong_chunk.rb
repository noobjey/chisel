class StrongChunk
  attr_reader :text

  def initialize(input)
    @text = input
  end

  def render
    result = text
    while is_strong?(result)
      result = result.sub('**', '<strong>').sub('**', '</strong>')
    end
    result
  end

  def is_strong?(text)
    text.include?('**')
  end
end
