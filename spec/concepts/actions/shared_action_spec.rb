require 'rails_helper'

shared_examples_for 'an action' do
  subject { action }

  it { should respond_to :process }
  it { should respond_to :end_of_turn? }
  it { should respond_to :valid? }
  it { should respond_to :errors }
end
