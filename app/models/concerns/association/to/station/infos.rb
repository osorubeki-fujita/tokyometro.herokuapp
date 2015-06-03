module Association::To::Station::Infos
  extend ActiveSupport::Concern
  included do
    has_many :station_infos , class: ::Station::Info
  end
end
