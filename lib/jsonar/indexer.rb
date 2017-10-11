require 'json'

module Jsonar
  class Indexer
    def self.build_index(json)
      input = JSON.parse(json)

      # assume the json input is always an array at the top level
      index = {}
      input.each do |item|
        update_index(item, item, index)
      end

      index
    end

    private_class_method

    def self.update_index(root, input, index)
      if input.is_a? Array
        input.each do |item|
          update_index(root, item, index)
        end
      elsif input.is_a? Hash
        input.each do |_, v|
          update_index(root, v, index)
        end
      else
        index[input] = root
      end

      index
    end
  end
end
