
__END__

module TokyoMetro::Modules::Api::Convert::Customize::StationTimetable::MarunouchiBranchLine

  def self.set_modules
    ::TokyoMetro::Api::StationTimetable::Info.class_eval do
      prepend ::TokyoMetro::Modules::Api::Convert::Customize::StationTimetable::MarunouchiBranchLine::Info
    end
  end

end