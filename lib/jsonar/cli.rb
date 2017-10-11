require 'jsonar/indexer'

module Jsonar
  class CLI
    def self.run(args)
      files = parse_args(args)
      return if files.nil?
      contents = File.read(files[0])
      puts contents

      index = Jsonar::Indexer.build_index(contents)
      query = get_query

      puts search(index, query)
    end

    private_class_method

    def self.parse_args(files)
      return files unless files.empty?
      puts 'Please specify a JSON file to search in'
      puts 'Usage: jsonar [FILE]...'
    end

    def self.get_query; end

    def self.search(_index, _query); end
  end
end