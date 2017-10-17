require 'json'
require 'set'

module Jsonar
  class Indexer
    def self.from_files(files = [])
      raise ArgumentError if files.empty?
      index = {}
      files.each do |file|
        index = Jsonar::Indexer.from_string(File.read(file), index)
      end
      index
    end

    private_class_method

    def self.from_string(json, index = {})
      input = JSON.parse(json)

      # assume the json input is always an array at the top level
      input.each do |item|
        index_fields(item, item, index)
      end

      index
    end

    def self.index_fields(root, input, index)
      if input.is_a? Array
        input.each do |item|
          index_fields(root, item, index)
        end
      elsif input.is_a? Hash
        input.each_value do |v|
          index_fields(root, v, index)
        end
      else
        input = input.to_s
        input = 'null' if input.empty?
        index[input] = index[input] || Set.new
        index[input] << root
      end

      index
    end
  end
end
