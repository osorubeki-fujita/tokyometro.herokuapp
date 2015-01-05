class PassengerSurvey < ActiveRecord::Base
  has_many :station_passenger_surveys
  has_many :stations , through: :station_passenger_surveys

  # 特定の年の路線を取得する
  scope :in_year , ->( year ) {
    where( survey_year: year )
  }

  scope :find_by_year , ->( year ) {
    find_by( survey_year: year )
  }

  # 指定された路線のデータを取得する。
  # 乗降人員の駅データにリンクしている駅（複数、同名でも路線ごとに異なる）を取得し、
  # 駅が設定された路線に所属しているか否かによって判定する。
  scope :select_railway_line , ->( railway_lines ) {
    railway_line_ids = railway_lines.pluck( :id ).uniq
    station_ids = ::Station.where( railway_line_id: railway_line_ids ).pluck( :id )
    passenger_survey_ids = ::StationPassengerSurvey.where( station_id: station_ids ).pluck( :passenger_survey_id )
    where( id: passenger_survey_ids )
  }

  # 設定された年・路線のデータを取得し、乗降人員が多い順に並び替える。
  scope :list_of_a_railway_line , ->( survey_year: nil , railway_lines: nil ) {
    raise "Error" if [ survey_year , railway_lines ].any?{ |i| i.nil? }
    # raise "Error: #{survey_year} , #{railway_lines_including_branch.pluck(:id).uniq.to_s}" if self.blank?
    in_year( survey_year ).select_railway_line( railway_lines ).order( passenger_journey: :desc )
  }
end
