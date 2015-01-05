module AssociationFromToStation

  extend ActiveSupport::Concern
  included do
    belongs_to :to_station , class_name: 'Station'
  end
end