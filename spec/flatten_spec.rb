require_relative '../lib/commands/flatten'

RSpec.describe Flatten do
  let(:flattener) { Flatten.new }

  let(:test_cases) do
    {
      [1, [2, [3, 4], 5], 6] => [1, 2, 3, 4, 5, 6],
      [] => [],
      [1, [2], [], [3, [4, [5]]]] => [1, 2, 3, 4, 5],
      [[[[]]]] => [],
      [1, [2, [3, [4, [5, [6]]]]]] => [1, 2, 3, 4, 5, 6]
    }
  end

  describe '#flatten_functional' do
    it 'flattens nested arrays correctly' do
      test_cases.each do |input, expected|
        expect(flattener.flatten_functional(input)).to eq(expected)
      end
    end
  end

  describe '#flatten_imperative' do
    it 'flattens nested arrays correctly' do
      test_cases.each do |input, expected|
        expect(flattener.flatten_imperative(input)).to eq(expected)
      end
    end
  end
end