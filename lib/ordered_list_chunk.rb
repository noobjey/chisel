class OrderedListChunk
  attr_reader :text

  def initialize(input)
    @text = input
  end

  def render
    list_items = add_list_html(text).rstrip
    <<-rendered_text
<ol>
  #{list_items}
</ol>

    rendered_text
  end

  def contains_ordered_list_markdown?(input)
    input.start_with?('1. ')
  end

  def add_list_html(input)
    result = ''
    list_items = input.split("\n")
    list_items.each do |list_item|
      result << "<li>#{remove_markdown(list_item)}</li>\n"
    end
    result
  end

  private

  def remove_markdown(input)
    input.slice(3...input.length).strip
  end
end
