class WomenOnlyCarInfo < ActiveRecord::Base
  belongs_to :operation_day
  belongs_to :railway_line

  include AssociationFromFromStation
  include AssociationFromToStation

  def section
    [ from_station , to_station ]
  end

  def available_time_from
    ::ApplicationHelper.time_strf( available_time_from_hour , available_time_from_min )
  end

  def available_time_until
    ::ApplicationHelper.time_strf( available_time_until_hour , available_time_until_min )
  end

  def available_time_to_s
    [ available_time_from , available_time_until ].join( " - " )
  end

  [ :from , :to ].each do | prefix |
    [ :ja , :en ].each do | lang |
      eval <<-DEF
        def #{prefix}_station_name_#{lang}
          #{prefix}_station.name_#{lang}
        end
      DEF
    end
  end

end