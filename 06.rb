module Day06
  class << self
    def part_one(input)
      find_unique_string_index(input.first, 4)
    end

    def part_two(input)
      find_unique_string_index(input.first, 14)
    end

    private

    def find_unique_string_index(full_string, unique_string_length)
      full_string.chars.each_cons(unique_string_length).with_index do |section, i|
        return i + unique_string_length if section.uniq.count == unique_string_length
      end
    end
  end
end
