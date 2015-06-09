require './lib/chunker'
require './lib/chunk_assigner'

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

    html.join
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
