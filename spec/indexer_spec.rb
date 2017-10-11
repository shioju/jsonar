require 'jsonar/indexer'

RSpec.describe Jsonar::Indexer do
  describe 'build_index' do
    it 'works for an array of objects with string values' do
      @json = '[{"foo": "bar"}]'
      expect(Jsonar::Indexer.build_index(@json)).to eq('bar' => [{ 'foo' => 'bar' }].to_set)
    end

    it 'works for an array of objects with integer values' do
      @json = '[{"foo": 3}]'
      expect(Jsonar::Indexer.build_index(@json)).to eq(3 => [{ 'foo' => 3 }].to_set)
    end

    it 'works for an array of objects with boolean values' do
      @json = '[{"foo": true}]'
      expect(Jsonar::Indexer.build_index(@json)).to eq(true => [{ 'foo' => true }].to_set)
    end

    it 'works for an array of objects with null values' do
      @json = '[{"foo": null}]'
      expect(Jsonar::Indexer.build_index(@json)).to eq(nil => [{ 'foo' => nil }].to_set)
    end

    it 'works for an array of objects with array fields' do
      @json = '[{"foo": ["bar", "baz"]}]'
      expect(Jsonar::Indexer.build_index(@json)).to eq('bar' => [{ 'foo' => %w[bar baz] }].to_set,
                                                       'baz' => [{ 'foo' => %w[bar baz] }].to_set)
    end

    it 'works for an array of objects with object fields' do
      @json = '[{"foo": {"bar": "baz"}}]'
      expect(Jsonar::Indexer.build_index(@json)).to eq('baz' =>
                                                         [{ 'foo' => { 'bar' => 'baz' } }].to_set)
    end
  end
end
