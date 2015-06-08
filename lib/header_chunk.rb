class HeaderChunk
  attr_reader :text, :header_level

  def initialize(text)
    @header_level = text.count('#')
    @text = text
  end

  def render
    "<h#{header_level}>#{stripped_text}</h#{header_level}>"
  end

  private

  def header_hashes
    '#' * header_level
  end

  def stripped_text
    text.sub(header_hashes, '').strip
  end
end
