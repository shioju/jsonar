require 'jsonar/cli'
require 'jsonar/version'

RSpec.describe Jsonar::CLI do
  describe '#run' do
    it 'prompts for input file if not specified' do
      expect { Jsonar::CLI.run }.to output(/specify a JSON file/).to_stdout
    end

    it 'displays usage string when input file is not specified' do
      expect { Jsonar::CLI.run }.to output(/Usage/).to_stdout
    end

    it 'calls the respective methods' do
      allow(STDOUT).to receive(:puts)
      allow(Jsonar::CLI).to receive(:loop).and_yield
      allow(Jsonar::CLI).to receive(:load_files).and_return('[]')

      expect(Jsonar::Indexer).to receive(:from_files)
      expect(Jsonar::CLI).to receive(:get_query)
      expect(Jsonar::CLI).to receive(:search)
      expect(Jsonar::CLI).to receive(:show_results)
      Jsonar::CLI.run 'foo'
    end
  end

  describe '#get_query' do
    it 'prompts the user' do
      allow(STDIN).to receive(:gets).and_return('')
      expect { Jsonar::CLI.get_query }
        .to output(/What are you looking for/).to_stdout
    end

    it 'strips trailing newline' do
      allow(STDOUT).to receive(:puts)
      allow(STDIN).to receive(:gets).and_return("foo\n")
      expect(Jsonar::CLI.get_query).to eq('foo')
    end
  end

  describe '#show_results' do
    it 'calls ap when result is not nil' do
      expect(Object).to receive(:ap)
      Jsonar::CLI.show_results('')
    end

    it 'prints not found message when result is nil' do
      expect { Jsonar::CLI.show_results(nil) }
        .to output(/No matching record found/).to_stdout
    end
  end
end
