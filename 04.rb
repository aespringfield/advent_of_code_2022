module Day04
  class << self
    def part_one(input)
      input.select do |line|
        assignment1, assignment2 = line.split(',').map { |str| Assignment.new(*clean_assignment_data(str)) }
        assignment1.contains?(assignment2) || assignment2.contains?(assignment1)
      end.count
    end

    def part_two(input)
      input.select do |line|
        assignment1, assignment2 = line.split(',').map { |str| Assignment.new(*clean_assignment_data(str)) }
        assignment1.overlaps_with?(assignment2)
      end.count
    end

    private

    def clean_assignment_data(str)
      str.split('-').map(&:to_i)
    end
  end

  class Assignment
    attr_accessor :start_value, :end_value

    def initialize(start_value, end_value)
      @start_value = start_value
      @end_value = end_value
    end

    def contains?(other_assignment)
      @start_value <= other_assignment.start_value && @end_value >= other_assignment.end_value
    end

    def overlaps_with?(other_assignment)
      starts_inside?(other_assignment) || other_assignment.starts_inside?(self)
    end

    def starts_inside?(other_assignment)
      @start_value >= other_assignment.start_value && @start_value <= other_assignment.end_value
    end
  end
end
