class UnorderedListChunk
  attr_reader :text

  def initialize(input)
    @text = input
  end

  def contains_unordered_list_markdown?(input)
    input.start_with?('* ')
  end

  def add_list_html(input)
    result = ''
    list_items = input.split("\n")
    list_items.each do |list_item|
      result << "<li>#{remove_markdown(list_item)}</li>\n"
    end
    result
  end

  def render
    list_items = add_list_html(text).rstrip
    <<-rendered_text
<ul>
  #{list_items}
</ul>

    rendered_text
  end

  private

  def remove_markdown(input)
    input.delete('*').strip
  end
end
