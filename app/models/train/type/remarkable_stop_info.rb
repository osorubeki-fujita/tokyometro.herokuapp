class Train::Type::RemarkableStopInfo < ActiveRecord::Base
  belongs_to :train_type_info , class: ::Train::Type::Info
  belongs_to :remarkable_stop_info , class: ::Station::Info
end
