class LinkChunk
  attr_reader :text

  def initialize(input)
    @text = input
  end

  def render
    result = text
    while contains_link_markdown?(result)
      result = to_html(result)
    end
    result
  end

  def to_html(input)
    http_attribute_markdown = get_href_markdown(input)
    link_markdown_block     = get_line_markdown(input)

    link_html      = add_link_text(link_markdown_block)
    href_attribute = add_http_attribute(http_attribute_markdown)

    html = inject_attribute_into_link_tag(link_html, href_attribute)

    input.sub(link_markdown_block + http_attribute_markdown, html)
  end

  def add_link_text(input)
    "<a>#{remove_markdown(input)}</a>"
  end

  def add_http_attribute(input)
    "href=\"#{remove_markdown(input)}\""
  end

  def contains_link_markdown?(input)
    input.include?('(http:')
  end

  private

  def get_href_markdown(input)
    opening_paren           = input.index('(')
    closing_paren           = input.index(')')
    input.slice(opening_paren..closing_paren)
  end

  def get_line_markdown(input)
    opening_block_position = input.index('[')
    closing_block_position = input.index(']')
    input.slice(opening_block_position..closing_block_position)
  end

  def inject_attribute_into_link_tag(link, attribute)
    link.sub('a>', "a #{attribute}>")
  end

  def remove_markdown(input)
    input.sub('[', '').sub(']', '').sub('(', '').sub(')', '')
  end
end
