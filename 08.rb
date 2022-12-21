require 'matrix'
require 'ostruct'
require_relative 'lib/array_helpers'

module Day08
  class << self
    include ArrayHelpers

    AXES = OpenStruct.new(
      {
        ROWS: :rows,
        COLUMNS: :columns
      }
    ).freeze

    DIRECTIONS = OpenStruct.new(
      {
        LEFT: :left,
        TOP: :top,
        RIGHT: :right,
        BOTTOM: :bottom
      }
    )

    DIRECTIONS_CONFIG = OpenStruct.new(
      {
        DIRECTIONS.LEFT => OpenStruct.new(
          {
            REVERSE: false,
            ROWS: true
          }
        ),
        DIRECTIONS.TOP => OpenStruct.new(
          {
            REVERSE: false,
            ROWS: false
          }
        ),
        DIRECTIONS.RIGHT => OpenStruct.new(
          {
            REVERSE: true,
            ROWS: true
          }
        ),
        DIRECTIONS.BOTTOM => OpenStruct.new(
          {
            REVERSE: true,
            ROWS: false
          }
        )
      }
    ).freeze

    def part_one(input)
      trees = clean(input)
      [DIRECTIONS.LEFT, DIRECTIONS.TOP, DIRECTIONS.RIGHT, DIRECTIONS.BOTTOM]
        .map { |direction| get_visibility_matrix_for_direction(direction, trees) }
        .reduce(&:+)
        .count(&:positive?)

      # Method 1:
      #
      # in any given row/column, the tallest tree(s) will be visible
      # then look to the indexes above and below the tree block (single tree or outer edge of section bounded by tied trees)
      #   -> next tallest tree(s) will also be visible.
      # repeat until have reached edges
      #
      # Method 2:
      #
      # Look at trees from each side. Keep track of current tallest.
      #   -> If tree not taller than current tallest, ignore. If tree taller, mark it visible and update current tallest
    end

    def part_two(input)
      # id hotspots
      # find sequences below x
    end

    private

    def clean(input)
      input.map { |line| line.chars.map(&:to_i) }
    end

    def find_sequences_below(x, trees, min_length: 1)
      horizontal_sequences = trees.each.with_index.with_object({}) do |(row, row_i), obj|
        result = row.each.with_index.with_object({ current_sequence: [], sequences: {} }) do |(height, column_i), row_obj|
          if height < x
            row_obj[:current_sequence] << [row_i, column_i]
          elsif !row_obj[:current_sequence].empty?
            provisional_start_column_i = row_obj[:current_sequence][0][1] - 1
            starts_on_edge = provisional_start_column_i.negative?
            start_column_i = starts_on_edge ? row_obj[:current_sequence][0][1] : provisional_start_column_i

            row_obj[:sequences][[[row_i, start_column_i], [row_i, column_i]]] = {
              length: row_obj[:current_sequence].length,
              start: starts_on_edge ? nil : trees[row_i][start_column_i],
              end: height
            }

            row_obj[:current_sequence] = []
          end
        end

        unfinished_sequence = result[:current_sequence]
        sequences = result[:sequences]

        unless unfinished_sequence.empty?
          start_row_i = row_i
          provisional_start_column_i = unfinished_sequence[0][1] - 1
          starts_on_edge = provisional_start_column_i.negative?
          start_column_i = starts_on_edge ? unfinished_sequence[0][1] : provisional_start_column_i

          sequences[[[row_i, start_column_i], unfinished_sequence.last]] = {
            length: unfinished_sequence.length,
            start: trees[start_row_i][start_column_i],
            end: nil
          }
        end

        obj.merge!(sequences)
      end

      {
        horizontal: horizontal_sequences
      }
    end

    # def get_visibility_matrix_for_all_directions(trees)
    #   tree_matrix = Matrix[*trees]
    #
    #   left_visibility = tree_matrix
    #                     .map.with_index.with_object(Array.new(tree_matrix.row_count, -1)) do |height, i, tallests|
    #
    #                     end
    # end

    def get_visibility_matrix_for_direction(direction, trees)
      row_count = trees.length
      column_count = trees.first.length
      tree_visibility_matrix = Matrix.build(row_count, column_count) { 0 }

      config = DIRECTIONS_CONFIG.[](direction)
      outer_bound = config.ROWS ? row_count : column_count
      inner_bound = config.ROWS ? column_count : row_count
      outer_range = 0.upto(outer_bound - 1)
      inner_range = (config.REVERSE ? (inner_bound - 1).downto(0) : 0.upto(inner_bound - 1))

      outer_range.each do |outer_i|
        inner_range.reduce(-1) do |max_height_so_far, inner_i|
          row_index, column_index = config.ROWS ? [outer_i, inner_i] : [inner_i, outer_i]
          height = trees[row_index][column_index]
          tree_visibility_matrix[row_index, column_index] = height > max_height_so_far ? 1 : 0
          height > max_height_so_far ? height : max_height_so_far
        end
      end

      tree_visibility_matrix
    end
  end
end
