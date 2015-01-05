module AssociationFromFromStation

  extend ActiveSupport::Concern
  included do
    belongs_to :from_station , class_name: 'Station'
  end
end