class Train::Type::InApi < ActiveRecord::Base

  has_many :infos , class: ::Train::Type::Info , foreign_key: :in_api_id

  include ::TokyoMetro::Modules::Name::Common::TrainType::InApi

  def train_type_infos
    infos
  end

end
