class AirConditioner::Answer < ActiveRecord::Base
  has_many :infos , class: ::AirConditioner::Info
end
