require 'jsonar/indexer'

module Jsonar
  class CLI
    def self.run(args = [])
      begin
        contents = load_files(args)
      rescue ArgumentError
        puts 'Please specify a JSON file to search in'
        puts 'Usage: jsonar [FILE]...'
        return
      rescue IOError => e
        puts e.to_s
        return
      end

      puts contents

      index = Jsonar::Indexer.build_index(contents)

      loop do
        query = get_query
        results = search(index, query)
        puts results
      end
    end

    private_class_method

    trap('INT') do
      exit
    end

    def self.load_files(files)
      raise ArgumentError, 'No files specified' if files.empty?
      File.read(files[0])
    end

    def self.get_query
      puts 'What are you looking for? (press Ctrl-c to exit)'
      query = STDIN.gets
      query && query.chomp || query
    end

    def self.search(index, query)
      index[query]
    end
  end
end
