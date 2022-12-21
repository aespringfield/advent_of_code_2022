require_relative 'lib/array_helpers'

module Day05
  class << self
    include ArrayHelpers

    def part_one(input)
      solve(input, reverse: true)
    end

    def part_two(input)
      solve(input, reverse: false)
    end

    private

    def solve(input, reverse: true)
      stacks_info, stacks_count, instructions = clean(input)
      stack_group = build_stack_group(stacks_info, stacks_count)
      stack_group.move_boxes!(instructions, reverse: reverse)
      stack_group.stacks.map(&:last).join
    end

    def clean(input)
      diagram, instructions = split_array(input, '')
      stacks_info = diagram[0..-2].map { |row| row.scan(/(...)?\s?/).flatten }
      stacks_count = diagram.last.split('   ').count
      [stacks_info, stacks_count, parse_instructions(instructions)]
    end

    def parse_instructions(instructions)
      instructions.map do |instruction|
        matches = /^move (?<num_boxes>\d+) from (?<from_stack>\d+) to (?<to_stack>\d+)$/.match(instruction).named_captures
        {
          to_stack: matches['to_stack'].to_i - 1,
          from_stack: matches['from_stack'].to_i - 1,
          num_boxes: matches['num_boxes'].to_i
        }
      end
    end

    def build_stack_group(stacks_info, stacks_count)
      stacks = []
      (0..(stacks_count - 1)).each { stacks << [] }
      stacks_info.reverse.each do |row|
        row.each_with_index do |box, i|
          matchdata = /\[(\w)\]/.match(box)
          stacks[i] << matchdata.captures.first if matchdata
        end
      end

      StackGroup.new(stacks)
    end
  end

  class StackGroup
    attr_accessor :stacks

    def initialize(stacks)
      @stacks = stacks
    end

    def move_boxes!(instructions, reverse: true)
      instructions.each do |instruction|
        boxes_to_move = @stacks[instruction[:from_stack]].pop(instruction[:num_boxes])
        @stacks[instruction[:to_stack]].push(*(reverse ? boxes_to_move.reverse : boxes_to_move))
      end
    end
  end
end
