# frozen_string_literal: true

class HashConvert
  def initialize(hash)
    @hash = hash
  end

  def self.transform_functional(obj)
    case obj
    when Hash
      obj.each_with_object({}) do |(k, v), acc|
        acc[k] = transform_functional(v)
      end
    when Array
      obj.map { |el| transform_functional(el) }
         .reduce({}) { |acc, h| acc.merge(h) }
    else
      unless obj.is_a?(Symbol) || obj.is_a?(String)
        raise ArgumentError, "Unsupported value type: #{obj.class}"
      end
      { obj => {} }
    end
  end

  def self.transform_imperative(obj)
    if obj.is_a?(Hash)
      result = {}
      obj.each do |key, value|
        result[key] = transform_imperative(value)
      end
      result
    elsif obj.is_a?(Array)
      result = {}
      obj.each do |item|
        transformed = transform_imperative(item)
        transformed.each do |k, v|
          result[k] = v
        end
      end
      result
    else
      unless obj.is_a?(Symbol) || obj.is_a?(String)
        raise ArgumentError, "Unsupported value type: #{obj.class}"
      end
      { obj => {} }
    end
  end
end
