class ConnectingRailwayLine < ActiveRecord::Base
  include ::Association::To::Station::Info
  belongs_to :railway_line
  belongs_to :connecting_station_info , class_name: ::Station::Info , foreign_key: :connecting_station_info_id
  belongs_to :connecting_railway_line_note

  include ::TokyoMetro::Modules::Common::Info::Station::ConnectingRailwayLine
  include ::TokyoMetro::Modules::Common::Info::NewRailwayLine

  default_scope {
    if pluck( :index_in_station ).all?( &:present? )
      order( :index_in_station )
    elsif pluck( :index_in_station ).all?( &:blank? )
      order( :railway_line_id )
    # else
      # raise "Error"
    end
  }

  scope :display_on_railway_line_page , -> {
    where( hidden_on_railway_line_page: [ false , nil ] )
  }

  def note_instance
    connecting_railway_line_note
  end

  def note
    note_instance.note
  end

  [ :to_s , :to_a ].each do | method_base_name |
    eval <<-DEF
      def note_#{ method_base_name }
        note.#{ method_base_name }
      end
    DEF
  end

  def has_index_in_station?
    index_in_station.present?
  end

  def not_have_index_in_station?
    !( has_index_in_station? )
  end

  def not_operated_yet?
    super or railway_line.not_operated_yet?
  end

  def css_class_name
    railway_line.send( __method__ )
  end

end