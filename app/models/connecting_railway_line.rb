class ConnectingRailwayLine < ActiveRecord::Base
  belongs_to :station
  belongs_to :railway_line
  belongs_to :connecting_station , class_name: 'Station'
  belongs_to :connecting_railway_line_note

  [ :connecting_to_another_station , :cleared , :not_recommended ].each do | method_name |
    eval <<-DEF
      def #{ method_name }?
        #{ method_name }
      end
    DEF
  end

  def station
    connecting_station
  end

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

end