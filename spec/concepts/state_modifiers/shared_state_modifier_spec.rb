require 'rails_helper'

shared_examples_for 'a state modifier' do
  subject { action }

  it 'can be created from a state modifier' do
    action_model = Action.new
    expect(action.class.from_action(action_model)).to be_a action.class
  end

  it { should respond_to :process }
  it { should respond_to :end_of_turn? }
  it { should respond_to :valid? }
  it { should respond_to :errors }
  it { should respond_to :player_id }
end
