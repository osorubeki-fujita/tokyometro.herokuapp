module TokyoMetro::Modules::Api::Convert::Customize::Station::ChiyodaBranchLine::Generate::List

  def generate( max = nil )
    ary = super( max )

    chiyoda = "odpt.Railway:TokyoMetro.Chiyoda"
    chiyoda_branch = "odpt.Railway:TokyoMetro.ChiyodaBranch"

    ayase = ary.find { | item | item.same_as == "odpt.Station:TokyoMetro.Chiyoda.Ayase" }

    if ayase.present?
      ayase_branch = ::Marshal.load( Marshal.dump( ayase ) )

      ayase.connecting_railway_lines << self.class.connecting_railway_line_info_class.new( chiyoda_branch )
      ayase_branch.connecting_railway_lines << self.class.connecting_railway_line_info_class.new( chiyoda )

      ayase.connecting_railway_lines.set_index_in_station!.sort!
      ayase_branch.connecting_railway_lines.set_index_in_station!.sort!

      ayase_branch.instance_eval do
        @same_as = "odpt.Station:TokyoMetro.ChiyodaBranch.Ayase"
        @railway_line = chiyoda_branch
        @id_urn = nil
        @dc_date = nil
      end
      ary << ayase_branch
    end

    kita_ayase = ary.find { | item | item.same_as == "odpt.Station:TokyoMetro.Chiyoda.KitaAyase" }

    if kita_ayase.present?
      kita_ayase.instance_eval do
        @same_as = "odpt.Station:TokyoMetro.ChiyodaBranch.KitaAyase"
        @railway_line = chiyoda_branch
      end
    end

    return ary
  end

end