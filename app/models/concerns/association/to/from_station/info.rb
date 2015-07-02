module Association::To::FromStation::Info
  extend ActiveSupport::Concern
  included do
    belongs_to :from_station_info , class_name: ::Station::Info , foreign_key: :from_station_info_id
  end
end