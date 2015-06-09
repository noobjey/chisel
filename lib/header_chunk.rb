class HeaderChunk
  attr_reader :text, :header_level

  def initialize(text)
    @header_level = text.count('#')
    @text         = text
  end

  def render
    "<h#{header_level}>#{format_text(text)}</h#{header_level}>"
  end

  private

  def format_text(text)
    formatted = remove_markdown(text)
    remove_space_between_header_markdown(formatted)
  end

  def remove_markdown(text)
    text.delete('#')
  end

  def remove_space_between_header_markdown(text)
    text.strip
  end
end
