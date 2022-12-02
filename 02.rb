module Day02
  class << self
    NOTATIONS_TO_SHAPES = {
      'X' => :rock,
      'Y' => :paper,
      'Z' => :scissors,
      'A' => :rock,
      'B' => :paper,
      'C' => :scissors
    }.freeze

    # -1 is lose, 0 is tie, 1 is win
    NOTATIONS_TO_OUTCOMES = {
      'X' => -1,
      'Y' => 0,
      'Z' => 1
    }.freeze

    SHAPES_IN_ORDER = %i[
      rock
      paper
      scissors
    ].freeze

    SHAPE_SCORES = {
      rock: 1,
      paper: 2,
      scissors: 3
    }.freeze

    OUTCOME_SCORES = {
      1 => 6,
      0 => 3,
      -1 => 0
    }.freeze

    def part_one(input)
      input.map do |line|
        your_notation, my_notation = line.split(' ')
        your_shape = NOTATIONS_TO_SHAPES[your_notation]
        my_shape = NOTATIONS_TO_SHAPES[my_notation]
        calculate_score(determine_outcome(your_shape, my_shape), my_shape)
      end.sum
    end

    def part_two(input)
      input.map do |line|
        your_notation, notation_for_outcome = line.split(' ')
        your_shape = NOTATIONS_TO_SHAPES[your_notation]
        outcome = NOTATIONS_TO_OUTCOMES[notation_for_outcome]
        calculate_score(outcome, determine_shape(your_shape, outcome))
      end.sum
    end

    private

    def calculate_score(outcome, my_shape)
      OUTCOME_SCORES[outcome] + SHAPE_SCORES[my_shape]
    end

    def determine_outcome(your_shape, my_shape)
      return 0 if your_shape == my_shape

      get_shape(your_shape, 1) == my_shape ? 1 : -1
    end

    def determine_shape(your_shape, outcome)
      case outcome
      when 0
        your_shape
      when 1
        get_shape(your_shape, 1)
      when -1
        get_shape(your_shape, -1)
      end
    end

    # The shapes are a circular graph, move along it in
    # either direction to find the winning/losing shape
    def get_shape(shape, distance)
      shape_index = SHAPES_IN_ORDER.find_index(shape)
      next_shape_index = (shape_index + distance) % 3
      SHAPES_IN_ORDER[next_shape_index]
    end
  end
end
