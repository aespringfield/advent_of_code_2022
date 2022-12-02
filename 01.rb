module Day01
  class << self
    def part_one(input)
      split_array(input, '', &:to_i).map(&:sum).max
    end

    def part_two(input)
      split_array(input, '', &:to_i).map(&:sum).max(3).sum
    end

    private

    def split_array(array, delimiter, &block)
      array.each_with_object([]) do |el, acc|
        acc << [] if acc.empty?

        if el == delimiter
          acc << []
        else
          acc.last << (block_given? ? block.call(el) : el)
        end
      end
    end
  end
end
