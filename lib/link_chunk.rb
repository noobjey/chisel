class LinkChunk
  attr_reader :markdown

  def initialize(markdown)
    @markdown = markdown
  end

  def render
    result = markdown
    while contains_link_markdown?(result)
      result = to_html(result)
    end
    result
  end

  def to_html(markdown)
    href_attribute_markdown               = get_href_markdown(markdown)
    title_attribute_markdown              = get_title_markdown(markdown)
    href_attribute_markdown_without_title = remove_title(href_attribute_markdown, title_attribute_markdown)
    link_markdown_block                   = get_line_markdown(markdown)

    href_attribute  = add_href_attribute(remove_title(href_attribute_markdown_without_title, title_attribute_markdown))
    title_attribute = add_title_attribute(title_attribute_markdown)
    link_html       = add_link_text(link_markdown_block)

    href_with_title = inject_title_attribute_into_href(href_attribute, title_attribute)
    html_with_href  = inject_href_attribute_into_link_tag(link_html, href_with_title)

    markdown.sub(link_markdown_block + href_attribute_markdown, html_with_href)
  end

  def remove_title(href_markdown, title_attribute_markdown)
    if title_attribute_markdown.nil?
      result = href_markdown
    else
      result = href_markdown.sub(' ' + title_attribute_markdown, '')
    end
    result
  end

  def add_link_text(markdown)
    "<a>#{remove_markdown(markdown)}</a>"
  end

  def add_href_attribute(markdown)
    "href=\"#{remove_markdown(markdown)}\""
  end

  def add_title_attribute(markdown)
    if markdown.empty?
      markdown
    else
      "title=#{markdown}"
    end
  end

  def contains_link_markdown?(markdown)
    markdown.include?('(http:')
  end

  private

  def get_href_markdown(markdown)
    opening_paren = markdown.index('(')
    closing_paren = markdown.index(')')
    markdown.slice(opening_paren..closing_paren)
  end

  def get_line_markdown(markdown)
    opening_block_position = markdown.index('[')
    closing_block_position = markdown.index(']')
    markdown.slice(opening_block_position..closing_block_position)
  end

  def get_title_markdown(markdown)
    href_markdown              = get_href_markdown(markdown)
    opening_title_double_quote = href_markdown.index('"')

    return '' if opening_title_double_quote.nil?

    closing_title_double_quote = href_markdown.index('"', opening_title_double_quote + 1)
    href_markdown.slice(opening_title_double_quote..closing_title_double_quote)
  end

  def inject_href_attribute_into_link_tag(link, href)
    link.sub('a>', "a #{href}>")
  end

  def inject_title_attribute_into_href(href, title)
    if title.empty?
      href
    else
      "#{href} #{title}"
    end
  end

  def remove_markdown(input)
    input.sub('[', '').sub(']', '').sub('(', '').sub(')', '')
  end
end
