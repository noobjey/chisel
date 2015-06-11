class EmChunk
  attr_reader :markdown

  def initialize(markdown)
    @markdown = markdown
  end

  def render
    result = markdown
    while contains_em_markdown?(result)
      result = result.sub('*', '<em>').sub('*', '</em>')
    end
    result
  end

  def contains_em_markdown?(markdown)
    markdown.include?('*')
  end
end
