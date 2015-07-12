module Association::To::FromStation::Info
  extend ActiveSupport::Concern
  included do
    belongs_to :from_station_info , class_name: ::Station::Info
  end
end
