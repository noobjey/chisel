require './lib/chunker'
require './lib/chunk_assigner'
require './lib/strong_chunk'

#hate the newlines in the chunktypes, refactor that back into renderer?

class Renderer

  def initialize(input)
    @input = input
  end

  def rend
    chunked = chunk(@input)
    assigned_chunks = assign(chunked)
    html = assigned_chunks.map do |chunk|
      convert_to_html(chunk)
    end

    inline_html = html.map do |chunk|
      strong_chunk = StrongChunk.new(chunk)
      strong_chunk.render
    end
    inline_html.join
  end

  def chunk(input)
    chunker = Chunker.new(input)
    chunker.chunks
  end

  def assign(input)
    chunk_assigner = ChunkAssigner.new(input)
    chunk_assigner.assign
  end

  def convert_to_html(input)
    input.render
  end
end
