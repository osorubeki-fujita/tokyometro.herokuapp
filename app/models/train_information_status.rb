class TrainInformationStatus < ActiveRecord::Base
  has_many :train_informations
  has_many :train_information_olds
end