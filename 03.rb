module Day03
  class << self
    def part_one(input)
      input.map do |line|
        compartment1, compartment2 = split_into_equal_halves(line.split(''))
        overlap = (compartment1 & compartment2).first
        overlap.ord - (overlap.upcase == overlap ? 38 : 96)
      end.sum
    end

    def part_two(input)
      input
        .each_slice(3)
        .to_a
        .map do |(rucksack1, rucksack2, rucksack3)|
          overlap = (rucksack1.split('') & rucksack2.split('') & rucksack3.split('')).first
          overlap.ord - (overlap.upcase == overlap ? 38 : 96)
        end.sum
    end

    private

    def split_into_equal_halves(array)
      [array[0..(array.length / 2)], array[(array.length / 2)..-1]]
    end
  end
end
