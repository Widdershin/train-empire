class Action < ActiveRecord::Base
  validates :type, presence: true
end
