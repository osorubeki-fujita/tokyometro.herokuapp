class Station::StoppingPattern::Info < ActiveRecord::Base
  include ::Association::To::Station::Info
  belongs_to :stopping_pattern , class: ::StoppingPattern
  has_many :train_type_infos , class: ::Train::Type::Info
  belongs_to :note , class: ::Station::StoppingPattern::Note
end
