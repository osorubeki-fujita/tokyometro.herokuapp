class ConnectingRailwayLine < ActiveRecord::Base
  belongs_to :station
  belongs_to :railway_line
  belongs_to :connecting_station , class_name: 'Station'
  belongs_to :connecting_railway_line_note

  include ::TokyoMetro::Modules::Common::Info::Station::ConnectingRailwayLine

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

end