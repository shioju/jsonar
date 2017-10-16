require 'jsonar/indexer'
require 'awesome_print'

module Jsonar
  class CLI
    def self.run(args = [])
      begin
        contents = load_files(args)
        puts contents
        index = Jsonar::Indexer.build_index(contents)
      rescue ArgumentError
        puts 'Please specify a JSON file to search in'
        puts 'Usage: jsonar [FILE]...'
        return
      rescue Errno::ENOENT => e
        puts e.message
        return
      rescue JSON::ParserError => e
        puts 'JSON file is invalid'
        puts e.message
        return
      end

      loop do
        query = get_query
        results = search(index, query)
        show_results(results)
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

    def self.show_results(result)
      if result
        ap result
      else
        puts 'No matching record found.'
      end
    end
  end
end
