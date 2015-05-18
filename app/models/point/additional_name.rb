class Point::AdditionalName < ActiveRecord::Base
  include ::Association::To::Point::Infos
  has_many :codes , class: ::Point::Code
end
