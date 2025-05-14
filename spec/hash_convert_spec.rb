# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/commands/hash_convert'

RSpec.describe HashConvert do
  describe 'using .transform method' do
    let(:input_hash) do
      {
        a: :a1,
        b: [:b1, :b2],
        c: { c1: :c2 },
        d: [:d1, [:d2, :d3], { d4: :d5 }],
        e: { e1: { e2: :e3 }, e4: [:e5, :e6] }
      }
    end

    let(:expected_output) do
      {
        a: { a1: {} },
        b: { b1: {}, b2: {} },
        c: { c1: { c2: {} } },
        d: { d1: {}, d2: {}, d3: {}, d4: { d5: {} } },
        e: { e1: { e2: { e3: {} } }, e4: { e5: {}, e6: {} } }
      }
    end

    context "with valid input" do
      it 'returned correct converted hash' do
        expect(HashConvert.transform(input_hash)).to eq(expected_output)
      end
    end

    context 'with invalid input' do
      let(:input_hash) do
        {
          a: 333,
          b: [:b1, :b2],
          c: { c1: 444 },
          d: [:d1, [:d2, :d3], { d4: "Text" }],
          e: { e1: { e2: :e3 }, e4: [567, :e6] }
        }
      end

      it 'raises error for wrong types' do
        expect { HashConvert.transform(input_hash) }.to raise_error(ArgumentError)
      end
    end

    context 'with empty input' do
      it 'returns empty hash' do
        expect(HashConvert.transform({})).to eq({})
      end
    end
  end
end
