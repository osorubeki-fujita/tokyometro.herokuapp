class Station::StoppingPattern::Note < ActiveRecord::Base
  has_many :station_stopping_pattern_infos , class: ::Station::StoppingPattern::Info
end
