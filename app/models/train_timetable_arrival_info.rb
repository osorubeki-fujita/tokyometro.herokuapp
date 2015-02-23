class TrainTimetableArrivalInfo < ActiveRecord::Base
  has_many :train_timetables
  belongs_to :station

  def platform_number_with_parentheses
    "(#{ platform_number })"
  end

end