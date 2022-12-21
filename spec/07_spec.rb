# frozen_string_literal: true
describe 'Day07' do
  describe '.part_one' do
    it 'returns 0 when top-level folder is empty' do
      input = ['$ cd /', '$ ls']
      expect(Day07.part_one(input)).to eq(0)
    end

    it "returns 0 when top-level folder's size is more than 100_000" do
      input = ['$ cd /', '$ ls', '14848514 b.txt']
      expect(Day07.part_one(input)).to eq(0)
    end

    it "returns top-level folder's size when top-level folder's size is less than 100_000" do
      input = ['$ cd /', '$ ls', '8514 b.txt']
      expect(Day07.part_one(input)).to eq(8514)
    end

    it "returns nested folders' contents added together when both less than 100_000" do
      input = ['$ cd /', '$ ls', '8514 b.txt', 'dir d', '$ cd d', '$ ls', '444 q']
      expect(Day07.part_one(input)).to eq(8514 + 444 + 444)
    end

    it "handles backwards directory change" do
      input = ['$ cd /', '$ ls', '8514 b.txt', 'dir d', '$ cd d', '$ cd ..', '$ cd d', '$ ls', '444 q']
      expect(Day07.part_one(input)).to eq(8514 + 444 + 444)
    end

    it "handles long directory names" do
      input = ['$ cd /', '$ ls', '8514 b.txt', 'dir droopywhoop', '$ cd droopywhoop', '$ ls', '444 q']
      expect(Day07.part_one(input)).to eq(8514 + 444 + 444)
    end

    it 'produces the correct output' do
      expect(Day07.part_one(@input)).to eq(@part_one_expected)
    end
  end

  describe '.part_two' do
    it 'produces the correct output' do
      expect(Day07.part_two(@input)).to eq(@part_two_expected)
    end
  end

  describe '.determine_space_to_free' do
    it 'returns 0 if there is more than enough space' do
      filesizes = {
        '/' => Day07::TOTAL_SPACE - Day07::NEEDED_SPACE - 10_000
      }

      expect(Day07.send(:determine_space_to_free, filesizes)).to eq(0)
    end

    it 'returns 0 if there is exactly enough space' do
      filesizes = {
        '/' => Day07::TOTAL_SPACE - Day07::NEEDED_SPACE
      }

      expect(Day07.send(:determine_space_to_free, filesizes)).to eq(0)
    end

    it 'returns correct amount when there is not enough space' do
      filesizes = {
        '/' => Day07::TOTAL_SPACE - Day07::NEEDED_SPACE + 30_000
      }

      expect(Day07.send(:determine_space_to_free, filesizes)).to eq(30_000)
    end
  end

  describe '.add_filesizes' do
    it 'returns the correct sums' do
      file_structure = {
        'a' => {
          'b' => {
            'c' => 10_000,
            'd' => 14_000
          },
          'c' => {
            'e' => 15_000
          }
        },
        'b' => {
          'c' => 100
        }
      }

      expect(Day07.send(:add_filesizes, file_structure)).to eq({
        'a' => 39_000,
        'a/b' => 24_000,
        'a/c' => 15_000,
        'b' => 100
      })
    end

    it 'returns the correct sums when the base directory is /' do
      file_structure = {
        '/' => {
          'b' => {
            'c' => 10_000,
            'd' => 14_000
          },
          'c' => {
            'e' => 15_000
          }
        }
      }

      expect(Day07.send(:add_filesizes, file_structure)).to eq({
        '/' => 39_000,
        '/b' => 24_000,
        '/c' => 15_000,
      })
    end
  end
end