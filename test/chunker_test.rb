require 'minitest/autorun'
require 'minitest/pride'
require './lib/chunker'

class ChunkerTest < Minitest::Test

  def test_chunk_contains_message
    message = "i am the message"
    chunker = Chunker.new

    result = chunker.chunk message

    assert_equal message, result[0]
  end

  def test_one_line_message_results_in_one_chunk
    message = "this is one line"
    chunker = Chunker.new

    result = chunker.chunk message

    assert_equal 1, result.length
  end

  def test_two_line_message_results_in_one_chunk
    message = "this is line one\nthis is line two"
    chunker = Chunker.new

    result = chunker.chunk message

    assert_equal 1, result.length
  end

  def test_two_newlines_in_a_row_makes_a_new_chunk
    message = "this is chunk one\n\nthis is chunk two"
    chunker = Chunker.new

    result = chunker.chunk message

    assert_equal 2, result.length
  end

end
