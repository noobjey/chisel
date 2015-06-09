require 'minitest/autorun'
require 'minitest/pride'
require './lib/chunk_assigner'
require './lib/header_chunk'
require './lib/paragraph_chunk'

class ChunkAssignerTest < Minitest::Test

  def test_takes_array_of_strings
    input = ["string", "more"]
    chunk_assigner = ChunkAssigner.new(input)

    assert_equal input[0], chunk_assigner.inputs[0]
  end

  def test_can_add_a_header_chunk
    chunk_assigner = ChunkAssigner.new(["# I am a header"])

    result = chunk_assigner.assign

    assert result[0].is_a?(HeaderChunk), "Actual: #{result[0].class}"
  end

  def test_can_add_a_paragraph_chunk
    chunk_assigner = ChunkAssigner.new(["I am a paragraph"])

    result = chunk_assigner.assign

    assert result[0].is_a?(ParagraphChunk), "Actual: #{result[0].class}"
  end

  def test_can_add_multiple_chunks
    chunk_assigner = ChunkAssigner.new(["I am a paragraph", "# I am a header", "# I am another header"])

    result = chunk_assigner.assign

    assert result[0].is_a?(ParagraphChunk), "Actual: #{result[0].class}"
    assert result[1].is_a?(HeaderChunk), "Actual: #{result[1].class}"
    assert result[2].is_a?(HeaderChunk), "Actual: #{result[2].class}"
  end
end
