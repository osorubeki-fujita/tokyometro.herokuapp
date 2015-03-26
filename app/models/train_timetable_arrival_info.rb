class TrainTimetableArrivalInfo < ActiveRecord::Base
  has_many :train_timetables
  include ::Association::To::Station::Info

  def platform_number_with_parentheses
    "(#{ platform_number })"
  end

end