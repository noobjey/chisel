require_relative 'header_chunk'
require_relative 'paragraph_chunk'

class ChunkAssigner
  attr_reader :inputs

  def initialize(input)
    @inputs = input
  end

  def assign
    chunks = inputs.map do |input|
      assign_chunk(input)
    end
    chunks
  end


  private

  def assign_chunk(input)
    if is_a_header input
      HeaderChunk.new("something")
    else
      ParagraphChunk.new("something")
    end
  end

  def is_a_header chunk
    chunk.start_with?('#')
  end
end
