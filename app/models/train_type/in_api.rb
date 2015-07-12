class TrainType::InApi < ActiveRecord::Base
  has_many :infos , class: ::TrainType::Info , foreign_key: :in_api_id
  has_many :train_locations

  include ::TokyoMetro::Modules::Common::Info::TrainType::InApi

  def train_type_infos
    infos
  end

end
