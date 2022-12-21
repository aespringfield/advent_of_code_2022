require_relative 'lib/array_helpers'

module Day01
  class << self
    include ArrayHelpers

    def part_one(input)
      split_array(input, '', &:to_i).map(&:sum).max
    end

    def part_two(input)
      split_array(input, '', &:to_i).map(&:sum).max(3).sum
    end
  end
end
