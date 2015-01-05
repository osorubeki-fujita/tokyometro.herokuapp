module TokyoMetro::ApiModules::TimetableModules::StationTimetable::Info::Seed::PatternB

  def seed( operators , railway_lines , stations , railway_directions , whole: nil , now_at: nil , indent: 0 )
    seed_common( operators , railway_lines , stations , railway_directions , whole: whole , now_at: now_at , indent: indent )
  end

end