require 'rails_helper'

RSpec.describe Action, :type => :model do
  it { should validate_presence_of :type }
end
