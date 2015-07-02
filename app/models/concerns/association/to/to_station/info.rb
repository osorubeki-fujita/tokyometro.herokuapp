module Association::To::ToStation::Info
  extend ActiveSupport::Concern
  included do
    belongs_to :to_station_info , class_name: ::Station::Info , foreign_key: :to_station_info_id
  end
end