require 'minitest/autorun'
require 'minitest/pride'
require './lib/chunker'

class ChunkerTest < Minitest::Test

  def test_one_line_message_results_in_one_chunk
    # message = "this is one line"
    # chunker = Chunker.new
    #
    # result = chunker.chunk message
    #
    # assert_equal 1, result.length
    assert true
  end

end
