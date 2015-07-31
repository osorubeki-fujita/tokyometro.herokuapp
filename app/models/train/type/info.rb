class Train::Type::Info < ActiveRecord::Base

  include ::TokyoMetro::Modules::Name::Common::TrainType::CssClass
  include ::TokyoMetro::Modules::Name::Common::TrainType::ColorBasename

  belongs_to :in_api , class: ::Train::Type::InApi
  belongs_to :railway_line_info , class: ::Railway::Line::Info

  has_many :station_train_times , class: ::Station::TrainTime , foreign_key: :train_type_info_in_this_station_id
  has_many :travel_time_infos , class: ::Railway::Line::TravelTimeInfo , foreign_key: :train_type_info_id

  has_many :train_type_stopping_patterns , class: ::Train::Type::StoppingPattern , foreign_key: :train_type_info_id
  has_many :stopping_patterns , through: :train_type_stopping_patterns

  has_many :train_timetable_train_type_in_other_operator_infos , class: ::Train::Timetable::TrainTypeInOtherOperatorInfo , foreign_key: :train_type_info_id
  has_many :train_location_infos , class: ::Train::Location::Info , foreign_key: :train_type_info_id

  belongs_to :color_info , class: ::Train::Type::ColorInfo
  has_one :note_info , class: ::Train::Type::Note::Info , foreign_key: :info_id

  # @!group Note info

  def note_str
    str = ::String.new
    str << note_text_ja

    _additional_texts_ja_to_a = additional_texts_ja_to_a
    if _additional_texts_ja_to_a.present?
      str_in_ary_of_additional_texts = _additional_texts_ja_to_a.join( "／")
      str << "（#{ str_in_ary_of_additional_texts }）"
    end

    _specific_operation_days = specific_operation_days
    if _specific_operation_days.present?
      str_in_ary_of_specific_operation_days = _specific_operation_days.pluck( :name_ja ).join( "・" )
      str << "【#{ str_in_ary_of_specific_operation_days }運行】"
    end

    _remarkable_stop_infos = remarkable_stop_infos
    if _remarkable_stop_infos.present?
      str_in_ary_of_remarkable_stop_infos = _remarkable_stop_infos.pluck( :name_ja ).join( "、")
      str << "【#{ str_in_ary_of_remarkable_stop_infos }に停車】"
    end



    str
  end

  #---- train_type_note_infos
  has_one :note_info , class: ::Train::Type::Note::Info , foreign_key: :info_id

  def note_text
    note_info.text
  end

  def note_text_ja
    note_info.text.text_ja
  end

  # @!group Additional infos

  has_many :additional_infos , class: ::Train::Type::Note::Additional::Info , foreign_key: :info_id
  has_many :additional_texts , class: ::Train::Type::Note::Additional::Text , through: :additional_infos

  def additional_texts_ja_to_a
    additional_texts.pluck( :text_ja )
  end

  # @!group Train type specific operation days

  has_many :train_type_specific_operation_days , class: ::Train::Type::SpecificOperationDay , foreign_key: :train_type_info_id
  has_many :specific_operation_days , class: ::OperationDay , through: :train_type_specific_operation_days

  # @!group Train type remarkable stop infos

  has_many :train_type_remarkable_stop_infos , class: ::Train::Type::RemarkableStopInfo , foreign_key: :train_type_info_id
  has_many :remarkable_stop_infos , class: ::Station::Info , through: :train_type_remarkable_stop_infos

  # @!group Train type through operation infos

  has_many :train_type_through_operation_infos , class: ::Train::Type::ThroughOperationInfo , foreign_key: :info_id
  has_many :to_station_infos , class: ::Station::Info , through: :train_type_through_operation_infos

  # @!endgroup

  scope :select_colored_if_exist , -> {
    colored = select( &:colored? )
    if colored.present?
      colored
    else
      select( &:normal? )
    end
  }

  scope :defined , -> {
    where.not( same_as: "custom.TrainType:Undefined" )
  }

  def normal?
    /Normal/ === same_as
  end

  def colored?
    /Colored\Z/ === same_as
  end

  def operator_info_id
    railway_line_info.operator_info_id
  end

  # @!group Color

  def has_color_infos?
    color.present? and bgcolor.present?
  end

  def color
    color_info.color
  end

  def bgcolor
    color_info.bgcolor
  end

  # @!endgroup

end
