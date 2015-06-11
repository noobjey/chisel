class HeaderChunk
  attr_reader :text, :header_level

  def initialize(text)
    @header_level = text.count('#')
    @text         = text.strip
  end

  def render
    <<-html_with_newlines
<h#{header_level}>#{format_text(text)}</h#{header_level}>

    html_with_newlines
  end

  private

  def format_text(text)
    remove_space_between_header_markdown(remove_markdown(text))
  end

  def remove_markdown(text)
    text.delete('#')
  end

  def remove_space_between_header_markdown(text)
    text.strip
  end
end
