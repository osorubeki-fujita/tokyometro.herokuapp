module Association::To::Point::Info
  extend ActiveSupport::Concern
  included do
    belongs_to :point_info , class: ::Point::Info
  end
end
