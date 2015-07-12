module Association::To::ToStation::Info
  extend ActiveSupport::Concern
  included do
    belongs_to :to_station_info , class_name: ::Station::Info
  end
end
