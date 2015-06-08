class Chunker
  def initialize
    @chunks = []
  end

  def chunk input
    @chunks = input.split "\n\n"
  end
end

