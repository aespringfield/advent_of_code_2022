module Day07
  TOTAL_SPACE = 70_000_000
  NEEDED_SPACE = 30_000_000

  class << self
    def part_one(input)
      add_filesizes(get_file_structure_from_terminal_output(input)).values.reject { |val| val > 100_000 }.sum
    end

    def part_two(input)
      added_filesizes = add_filesizes(get_file_structure_from_terminal_output(input))
      space_to_free = determine_space_to_free(added_filesizes)
      added_filesizes.values.select { |added_filesize| added_filesize >= space_to_free }.min
    end

    private

    def get_file_structure_from_terminal_output(terminal_output)
      terminal_output.each_with_object({ file_structure: {}, current_path: [], listing: false }) do |line, obj|
        file_structure = obj[:file_structure]
        current_path = obj[:current_path]

        if /^\$/.match(line)
          obj[:listing] = false

          current_path.pop && next if /^\$ cd \.\.$/.match(line)

          new_dir = /^\$ cd ([\/,\w]+)$/.match(line)&.captures&.first
          if new_dir
            if current_path.empty?
              file_structure[new_dir] ||= {}
            else
              file_structure.dig(*current_path)[new_dir] ||= {}
            end

            current_path << new_dir
          elsif /^\$ ls/.match(line)
            obj[:listing] = true
          end
        elsif obj[:listing] == true
          next if /^dir (\w+)$/.match(line)

          filesize, filename = /^(\d+) ([\w,\.]+)$/.match(line)&.captures
          if current_path.empty?
            file_structure[new_dir] ||= filesize.to_i
          else
            file_structure.dig(*current_path)[filename] ||= filesize.to_i
          end
        end
      end[:file_structure]
    end

    def add_filesizes(file_structure, path = [])
      file_structure.each_pair.with_object({}) do |(key, value), obj|
        new_obj = if value.is_a?(Numeric)
                    (0..(path.size - 1)).each_with_object({}) do |i, new_obj|
                      path_string = path[0] == '/' ? path[0] + path[1..i].join('/') : path[0..i].join('/')
                      new_obj[path_string] = value
                    end
                  else
                    add_filesizes(value, [*path, key])
                  end

        obj.merge!(new_obj) { |_, old_val, new_val| old_val + new_val }
      end
    end

    def determine_space_to_free(filesizes)
      space_to_free = NEEDED_SPACE - (TOTAL_SPACE - filesizes['/'])
      space_to_free.positive? ? space_to_free : 0
    end
  end
end
