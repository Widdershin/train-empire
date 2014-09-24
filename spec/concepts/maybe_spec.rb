require 'rails_helper'

describe Maybe do
  describe '.wrap' do
    it 'returns the value if non nil' do
      expect(Maybe.wrap(:foo)).to eq :foo
    end

    it 'returns a maybe otherwise' do
      expect(Maybe.wrap(nil)).to be_a Maybe
    end
  end

  describe '#method_missing' do
    let(:maybe) { Maybe.new }
    subject { maybe }

    it 'chains indefinitely' do
      expect(maybe.a.b.c.arbitrary).to eq maybe
    end

    it {should be_nil}
  end
end
