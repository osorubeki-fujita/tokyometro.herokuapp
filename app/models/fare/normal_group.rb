class Fare::NormalGroup < ActiveRecord::Base
  has_many :infos , class: ::Fare::Info , foreign_key: :normal_group_id
end
