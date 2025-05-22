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

    let(:invalid_input) do
      {
        a: 333,
        b: [:b1, :b2],
        c: { c1: 444 },
        d: [:d1, [:d2, :d3], { d4: "Text" }],
        e: { e1: { e2: :e3 }, e4: [567, :e6] }
      }
    end

    context 'functional style (.transform_functional)' do
      it 'returns correct converted hash for valid input' do
        expect(HashConvert.transform_functional(input_hash)).to eq(expected_output)
      end

      it 'raises error for invalid input' do
        expect { HashConvert.transform_functional(invalid_input) }.to raise_error(ArgumentError)
      end

      it 'returns empty hash for empty input' do
        expect(HashConvert.transform_functional({})).to eq({})
      end
    end

    context 'imperative style (.transform_imperative)' do
      it 'returns correct converted hash for valid input' do
        expect(HashConvert.transform_imperative(input_hash)).to eq(expected_output)
      end

      it 'raises error for invalid input' do
        expect { HashConvert.transform_imperative(invalid_input) }.to raise_error(ArgumentError)
      end

      it 'returns empty hash for empty input' do
        expect(HashConvert.transform_imperative({})).to eq({})
      end
    end
  end
end
