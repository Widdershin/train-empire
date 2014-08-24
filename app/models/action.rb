class Action < ActiveRecord::Base
  belongs_to :player

  validates :type, presence: true
end
