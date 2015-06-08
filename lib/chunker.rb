class Chunker
  def initialize block_of_text
    @text = block_of_text
  end

  def chunks
    # caches value of @chunks only gets first version
    @chunks ||= @text.split "\n\n"
  end
end

