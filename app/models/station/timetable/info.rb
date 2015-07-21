class Station::Timetable::Info < ActiveRecord::Base
  has_many :station_train_times , class: ::Station::TrainTime , foreign_key: :station_timetable_info_id
  has_many :fundamental_infos , class: ::Station::Timetable::FundamentalInfo , foreign_key: :info_id

  has_many :station_infos , through: :fundamental_infos , class: ::Station::Info
  has_many :railway_line_infos , through: :fundamental_infos , class: ::Railway::Line::Info
  has_many :operators , through: :fundamental_infos
  has_many :railway_directions , through: :fundamental_infos

  def has_only_one_fundamental_info?
    fundamental_infos.length == 1
  end

    def station_timetable_fundamental_infos
      fundamental_infos
    end


end
