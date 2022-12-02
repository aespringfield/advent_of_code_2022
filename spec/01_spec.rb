describe 'Day01' do
  describe '.part_one' do
    it 'produces the correct output' do
      expect(Day01.part_one(@input)).to eq(24_000)
    end
  end

  describe '.part_two' do
    it 'produces the correct output' do
      expect(Day01.part_two(@input)).to eq(45_000)
    end
  end
end
