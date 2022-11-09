# frozen_string_literal: true

class Node
  attr_accessor :left, :right, :data

  def initialize(data)
    @data = data
    @left = @right = nil
  end

  def <=>(other)
    @data <=> other.data
  end
end