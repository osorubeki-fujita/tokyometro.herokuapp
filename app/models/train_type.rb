class TrainType < ActiveRecord::Base

  has_many :train_times
  has_many :travel_time_infos
  has_many :train_type_stopping_patterns
  has_many :stopping_patterns , through: :train_type_stopping_patterns

  belongs_to :train_type_in_api
  belongs_to :railway_line

  scope :select_colored_if_exist , -> {
    colored = select( &:colored? )
    if colored.present?
      colored
    else
      select( &:normal? )
    end
  }

  def in_api
    train_type_in_api
  end

  def normal?
    /Normal/ === same_as
  end

  def colored?
    /Colored\Z/ === same_as
  end

end
