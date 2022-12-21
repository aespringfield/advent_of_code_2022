describe 'Day05' do
  describe '.part_one' do
    it 'produces the correct output' do
      expect(Day05.part_one(@input)).to eq(@part_one_expected)
    end
  end

  describe '.part_two' do
    it 'produces the correct output' do
      expect(Day05.part_two(@input)).to eq(@part_two_expected)
    end
  end
end