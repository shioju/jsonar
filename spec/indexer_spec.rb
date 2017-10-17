require 'jsonar/indexer'

RSpec.describe Jsonar::Indexer do
  describe '#from_files' do
    it 'raises ArgumentError when no argument provided' do
      expect { Jsonar::Indexer.from_files }.to raise_error ArgumentError
    end

    it 'raises an error when the specified file is not found' do
      expect { Jsonar::Indexer.from_files ['foo'] }.to raise_error Errno::ENOENT
    end

    it 'loads the file when exists' do
      expect(Jsonar::Indexer).to receive(:from_string).once
      Jsonar::Indexer.from_files ['fixtures/simple.json']
    end
  end


  describe '#from_string' do
    it 'works for an array of objects with string values' do
      json = '[{"foo": "bar"}]'
      expect(Jsonar::Indexer.from_string(json))
        .to eq('bar' => [{ 'foo' => 'bar' }].to_set)
    end

    it 'works for an array of objects with integer values' do
      json = '[{"foo": 3}]'
      expect(Jsonar::Indexer.from_string(json))
        .to eq('3' => [{ 'foo' => 3 }].to_set)
    end

    it 'works for an array of objects with boolean values' do
      json = '[{"foo": true}]'
      expect(Jsonar::Indexer.from_string(json))
        .to eq('true' => [{ 'foo' => true }].to_set)
    end

    it 'works for an array of objects with null values' do
      json = '[{"foo": null}]'
      expect(Jsonar::Indexer.from_string(json))
        .to eq('null' => [{ 'foo' => nil }].to_set)
    end

    it 'works for an array of objects with array fields' do
      json = '[{"foo": ["bar", "baz"]}]'
      expect(Jsonar::Indexer.from_string(json))
        .to eq('bar' => [{ 'foo' => %w[bar baz] }].to_set,
               'baz' => [{ 'foo' => %w[bar baz] }].to_set)
    end

    it 'works for an array of objects with object fields' do
      json = '[{"foo": {"bar": "baz"}}]'
      expect(Jsonar::Indexer.from_string(json))
        .to eq('baz' => [{ 'foo' => { 'bar' => 'baz' } }].to_set)
    end

    it 'raises an error when given invalid json' do
      expect { Jsonar::Indexer.from_string('invalid json') }
        .to raise_error JSON::ParserError
    end

    it 'updates the provided index' do
      index = { '1' => [{ 'foo' => 1 }].to_set }
      json = '[{"bar": 2}]'
      expect(Jsonar::Indexer.from_string(json, index))
        .to eq('1' => [{ 'foo' => 1 }].to_set,
               '2' => [{ 'bar' => 2 }].to_set)
    end
  end
end
