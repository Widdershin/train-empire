require 'rails_helper'

shared_examples_for 'an action' do
  subject { action }

  it 'can be created from an action' do
    action_model = Action.new
    expect(action.class.from_action(action_model)).to be_a action.class
  end

  it { should respond_to :process }
  it { should respond_to :end_of_turn? }
  it { should respond_to :valid? }
  it { should respond_to :errors }
end
