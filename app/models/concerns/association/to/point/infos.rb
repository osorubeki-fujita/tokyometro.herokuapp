module Association::To::Point::Infos
  extend ActiveSupport::Concern
  included do
    has_many :infos , class: ::Point::Info

    def point_infos
      infos
    end

  end
end
