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
  scope :close , -> {
    closed
  }
  scope :not_opened , -> {
    closed
  }
  scope :not_open , -> {
    closed
  }
  scope :not_closed , -> {
    where( closed: [ false , nil ] )
  }
  scope :not_close , -> {
    not_closed
  }
  scope :opened , -> {
    not_closed
  }
  scope :open , -> {
    not_closed
  }

  def category
    point_category
  end

  [ :closed? , :close? , :close ].each do | method_name |
    eval <<-DEF
      def #{ method_name }
        closed
      end
    DEF
  end

  [ :opened? , :opened , :open? , :open ].each do | method_name |
    eval <<-DEF
      def #{ method_name }
        !( closed )
      end
    DEF
  end
  
  def has_code?
    code.present?
  end

  def has_elevator?
    elevator
  end

  def exit?
    category.exit?
  end

  def has_additional_info?
    additional_info_ja.present? or additional_info_en.present?
  end
  
  def invalid?
    !( has_code? ) and has_additional_info?
  end
  
  def code_of_number_and_alphabet?
    /\A[a-zA-z\d]+\Z/ === code
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
    marker.infowindow( [ code ].join( " " ) )
    marker.json( { title: json_title } )
  end

  def code_as_instance
    ::TokyoMetro::Api::Point::Info::Title::Code.new( code , additional_info_ja )
  end

end