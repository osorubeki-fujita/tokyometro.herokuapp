module Association::To::Station::Info
  extend ActiveSupport::Concern
  included do
    belongs_to :station_info , class: ::Station::Info , foreign_key: :station_info_id
  end
end