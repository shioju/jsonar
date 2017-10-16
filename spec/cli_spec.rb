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
  end

  describe '#load_files' do
    it 'raises ArgumentError when no argument provided' do
      expect { Jsonar::CLI.load_files }.to raise_error ArgumentError
    end

    it 'raises an error when the specified file is not found' do
      expect { Jsonar::CLI.load_files 'foo' }.to raise_error Errno::ENOENT
    end

    it 'loads the file when exists' do
      expected = "[]\n"
      actual = Jsonar::CLI.load_files ['fixtures/simple.json']
      expect(actual).to eq(expected)
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
end
