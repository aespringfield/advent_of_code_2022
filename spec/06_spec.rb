# frozen_string_literal: true
describe 'Day06' do
  describe '.part_one' do
    ('A'..'E').each do |letter|
      it "produces the correct output for example #{letter}" do
        expect(Day06.part_one(
          instance_variable_get("@input_#{letter}".to_sym)
        )).to eq(instance_variable_get("@part_one_expected_#{letter}".to_sym))
      end
    end
  end

  describe '.part_two' do
    ('A'..'E').each do |letter|
      it "produces the correct output for example #{letter}" do
        expect(Day06.part_two(
          instance_variable_get("@input_#{letter}".to_sym)
        )).to eq(instance_variable_get("@part_two_expected_#{letter}".to_sym))
      end
    end
  end
end