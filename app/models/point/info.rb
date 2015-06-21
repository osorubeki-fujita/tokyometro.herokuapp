class Point::Info < ActiveRecord::Base
  belongs_to :station_facility_info , class: ::StationFacility::Info

  has_many :station_points
  has_many :station_infos , through: :station_points

  belongs_to :category , class: ::Point::Category
  belongs_to :code , class: ::Point::Code

  def additional_name
    code.try( __method__ )
  end

  # geocoded_by :code
  # after_validation :geocode

  scope :station_infos , -> {
    station_facility_info.station_infos
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

  scope :without_invalid , -> {
    where.not( id_urn: "urn:ucode:_00001C000000000000010000030C40CF" )
  }

  def point_category
    category
  end

  def point_code
    code
  end

  def point_additional_name
    additional_name
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

  def has_additional_name?
    additional_name.present?
  end

  def has_elevator?
    elevator
  end

  def exit?
    category.exit?
  end

  def invalid?
    !( has_code? ) and has_additional_name?
  end

  def code_of_number_and_alphabet?
    has_code? and code.send( __method__ )
  end

  [ :ja , :en ].each do | lang |
    eval <<-DEF
      def category_name_#{ lang }
        category.name_#{ lang }
      end

      def additional_name_#{ lang }
        additional_name.try( :#{ lang } )
      end
    DEF
  end

  def set_to( marker , json_title )
    marker.lat( latitude )
    marker.lng( longitude )
    marker.infowindow( [ code ].join( " " ) )
    marker.json( { title: json_title } )
  end

  def code_to_s
    code.try( :main_to_s )
  end

  def code_as_instance
    ::TokyoMetro::Api::Point::Info::Title::Code.new( code_to_s , additional_name_ja )
  end

end
