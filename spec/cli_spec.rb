require 'jsonar/cli'
require 'jsonar/version'

RSpec.describe Jsonar::CLI do
  describe 'run' do
    it 'prompts for input file if not specified' do
      expect { Jsonar::CLI.run }.to output(/specify a JSON file/).to_stdout
    end

    it 'displays usage string when input file is not specified' do
      expect { Jsonar::CLI.run }.to output(/Usage/).to_stdout
    end
  end

  describe 'get_input' do
    it 'returns the input file path when provided' do
      expect(Jsonar::CLI.parse_args(['foo', 'bar'])).to eq(['foo', 'bar'])
    end
  end
end
