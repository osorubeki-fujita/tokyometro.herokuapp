class TimetableArrivalInfo < ActiveRecord::Base
  has_many :train_times
  belongs_to :station

  def platform_number_with_parentheses
    "(#{ self.platform_number })"
  end
end