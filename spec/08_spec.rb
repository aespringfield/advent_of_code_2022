describe 'Day08' do
  describe '.part_one' do
    it 'produces the correct output' do
      expect(Day08.part_one(@input)).to eq(@part_one_expected)
    end
  end

  describe '.part_two', skip: true do
    it 'produces the correct output' do
      expect(Day08.part_two(@input)).to eq(@part_two_expected)
    end
  end

  describe '.get_visibility_matrix_for_direction' do
    it 'returns correct matrix from left' do
      trees = [
        [1, 2, 3],
        [3, 2, 1],
        [1, 3, 2]
      ]
      expect(Day08.send(:get_visibility_matrix_for_direction, :left, trees)).to eq(Matrix[
        [1, 1, 1],
        [1, 0, 0],
        [1, 1, 0]
      ])
    end

    it 'returns correct matrix from top' do
      trees = [
        [1, 2, 3],
        [3, 2, 1],
        [1, 3, 2]
      ]
      expect(Day08.send(:get_visibility_matrix_for_direction, :top, trees)).to eq(Matrix[
        [1, 1, 1],
        [1, 0, 0],
        [0, 1, 0]
      ])
    end

    it 'returns correct matrix from right' do
      trees = [
        [1, 2, 3],
        [3, 2, 1],
        [1, 3, 2]
      ]
      expect(Day08.send(:get_visibility_matrix_for_direction, :right, trees)).to eq(Matrix[
        [0, 0, 1],
        [1, 1, 1],
        [0, 1, 1]
      ])
    end

    it 'returns correct matrix from bottom' do
      trees = [
        [1, 2, 3],
        [3, 2, 1],
        [1, 3, 2]
      ]
      expect(Day08.send(:get_visibility_matrix_for_direction, :bottom, trees)).to eq(Matrix[
        [0, 0, 1],
        [1, 0, 0],
        [1, 1, 1]
      ])
    end
  end

  describe '.find_sequences_below', skip: true do
    it 'returns sequences below x of at least y' do
      trees = [
        [1, 2, 4, 2, 5],
        [3, 2, 2, 3, 1],
        [1, 3, 2, 1, 0],
        [2, 5, 2, 0, 3],
        [2, 3, 5, 4, 0]
      ]

      expect(Day08.send(:find_sequences_below, 3, trees)).to eq(
        {
          horizontal: {
            [[0, 0], [0, 2]] => {
              length: 2,
              start: nil,
              end: 4
            },
            [[0, 2], [0, 4]] => {
              length: 1,
              start: 4,
              end: 5
            },
            [[1, 0], [1, 3]] => {
              length: 2,
              start: 3,
              end: 3
            },
            [[1, 3], [1, 4]] => {
              length: 1,
              start: 3,
              end: nil
            },
            [[2, 0], [2, 1]] => {
              length: 1,
              start: nil,
              end: 3
            },
            [[2, 1], [2, 4]] => {
              length: 3,
              start: 3,
              end: nil
            },
            [[3, 0], [3, 1]] => {
              length: 1,
              start: nil,
              end: 5
            },
            [[3, 1], [3, 4]] => {
              length: 2,
              start: 5,
              end: 3
            },
            [[3, 1], [3, 4]] => {
              length: 2,
              start: 5,
              end: 3
            },
            [[4, 0], [4, 1]] => {
              length: 1,
              start: nil,
              end: 3
            },
            [[4, 3], [4, 4]] => {
              length: 1,
              start: 4,
              end: nil
            }
          },
          vertical: {
            [[0, 0], [1, 0]] => {
              length: 1,
              start: nil,
              end: 3
            },
            [[1, 0], [4, 0]] => {
              length: 3,
              start: 3,
              end: nil
            },
            [[0, 1], [2, 1]] => {
              length: 2,
              start: nil,
              end: 3
            },
            [[0, 2], [4, 2]] => {
              length: 3,
              start: 4,
              end: 5
            },
            [[0, 3], [1, 3]] => {
              length: 1,
              start: nil,
              end: 3
            },
            [[1, 3], [4, 3]] => {
              length: 2,
              start: 3,
              end: 4
            },
            [[0, 4], [3, 4]] => {
              length: 2,
              start: 5,
              end: 3
            },
            [[3, 4], [4, 4]] => {
              length: 1,
              start: 3,
              end: nil
            }
          }
        }
      )
    end
  end
end