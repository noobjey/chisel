class StrongChunk
  attr_reader :text

  def initialize(input)
    @text = input
  end

  def render
    if is_strong?(text)
      first_strong = text.sub('**', '<strong>')
      first_strong.sub('**', '</strong>')
    else
      text
    end
  end

  def is_strong?(text)
    text.include?('**')
  end
end
