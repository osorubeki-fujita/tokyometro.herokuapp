class Point < ActiveRecord::Base
  belongs_to :station_facility
  belongs_to :point_category

  has_many :station_points
  has_many :station_infos , through: :station_points

  # geocoded_by :code
  # after_validation :geocode

  scope :station_infos , -> {
    station_facility.station_infos
  }

  scope :elevator , -> {
    where( elevator: true )
  }
  scope :closed , -> {
    where( closed: true )
  }
  scope :not_closed , -> {
    where( closed: [ false , nil ] )
  }
  
  def closed?
    closed
  end
  
  def has_elevator?
    elevator
  end
  
  def text_ja
    str = ::String.new
    if closed?
      str << "【現在閉鎖中】"
    end
    str << category_name_ja
    str << " "
    str << code.to_s
    if has_elevator?
      str << "（エレベーターあり）"
    end
    if additional_info.present?
      str << "（#{ additional_info }）"
    end
    str
  end

  def text_en
    str = ::String.new
    if closed?
      str << "[Closed] "
    end
    str << category_name_en
    str << " "
    str << code.to_s
    if has_elevator?
      str << " (With an elevator)"
    end
    str
  end

  [ :ja , :en ].each do | lang |
    eval <<-DEF
      def category_name_#{ lang }
        point_category.name_#{ lang }
      end
    DEF
  end

  def set_to( marker , json_title )
    marker.lat( latitude )
    marker.lng( longitude )
    marker.infowindow( [ text_ja , text_en ].join( " " ) )
    marker.json( { title: json_title } )
  end

end