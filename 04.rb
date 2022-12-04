module Day04
  class << self
    def part_one(input)
      input.select do |line|
        assignment1, assignment2 = line.split(',').map { |str| Range.new(*clean_assignment_data(str)) }
        assignment1.cover?(assignment2) || assignment2.cover?(assignment1)
      end.count
    end

    def part_two(input)
      input.select do |line|
        assignment1, assignment2 = line.split(',').map { |str| Range.new(*clean_assignment_data(str)) }
        assignment1.include?(assignment2.begin) || assignment2.include?(assignment1.begin)
      end.count
    end

    private

    def clean_assignment_data(str)
      str.split('-').map(&:to_i)
    end
  end

end
