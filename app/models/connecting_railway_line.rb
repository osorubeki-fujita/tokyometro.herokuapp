class ConnectingRailwayLine < ActiveRecord::Base
  belongs_to :station
  belongs_to :railway_line
  belongs_to :connecting_station , class_name: 'Station'
  belongs_to :connecting_railway_line_note

  include ::TokyoMetro::Modules::Common::Info::Station::ConnectingRailwayLine
  include ::TokyoMetro::Modules::Common::Info::NewRailwayLine

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

  default_scope {
    if pluck( :index_in_station ).all?( &:present? )
      order( :index_in_station )
    elsif pluck( :index_in_station ).all?( &:blank? )
      order( :railway_line_id )
    else
      raise "Error"
    end
  }

end