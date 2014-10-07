require 'rails_helper'

shared_examples_for 'a state modifier' do
  subject { modifier }

  it 'can be created from an action' do
    action_model = Action.new
    expect(modifier.class.from_action(action_model)).to be_a modifier.class
  end

  it { should respond_to :process }
  it { should respond_to :valid? }
  it { should respond_to :errors }
  it { should respond_to :player_id }
end
