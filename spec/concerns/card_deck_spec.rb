require 'rails_helper'

RSpec.describe CardDeck do
  it 'optionally takes an instance of random' do
    expect { CardDeck.new(random: Random.new) }.to_not raise_error
  end
end