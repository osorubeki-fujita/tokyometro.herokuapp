module TokyoMetro::Modules::Common::Info::Decision::CurrentStation

  #---------------- is_at_xxx?
  # @note ::TokyoMetro::Modules::Common::Dictionary::Station::StringInfo を用いて定義

  # @example
  #   at_honancho?
  #   at_nakano_fujimicho?
  #   at_nakano_shimbashi?
  #   at_nakano_sakaue_on_marunouchi_line?
  #   at_nakano_sakaue_on_marunouchi_branch_line?
  #   at_ogikubo?
  #   at_honancho_invalid?
  #   at_nakano_fujimicho_invalid?
  #   at_nakano_shimbashi_invalid?
  #   at_mitaka?
  #   at_tsudanuma?
  #   at_yoyogi_uehara?
  #   at_ayase_on_chiyoda_main_line?
  #   at_ayase_on_chiyoda_branch_line?
  #   at_kita_ayase_on_chiyoda_branch_line?
  #   at_kita_ayase_on_chiyoda_main_line?
  #   at_shirokane_takanawa?
  #   at_wakoshi_on_yurakucho_line?
  #   at_wakoshi_on_fukutoshin_line?
  #   at_kotake_mukaihara_on_yurakucho_line?
  #   at_kotake_mukaihara_on_fukutoshin_line?
  #   at_ikebukuro_on_yurakucho_line?
  #   at_ikebukuro_on_fukutoshin_line?
  #   at_motomachi_chukagai?

  ::TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.constants( false ).each do | const_name |
    base_method_name = const_name.to_s.downcase
    eval <<-DEF
      def at_#{ base_method_name }?
        station_same_as__is_in?( ::TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.#{ base_method_name } )
      end

      #-------- [alias]
      alias :is_at_#{ base_method_name }? :at_#{ base_method_name }?
    DEF
  end

  #---------------- is_at_xxx?
  # @note ::TokyoMetro::Modules::Common::Dictionary::Station::RegexpInfo を用いて定義

  # @example
  #   at_honancho_including_invalid?
  #   at_nakano_fujimicho_including_invalid?
  #   at_nakano_shimbashi_including_invalid?
  #   at_nakano_sakaue?
  #   at_ayase?
  #   at_kita_ayase?
  #   at_wakoshi?
  #   at_chikatetsu_narimasu?
  #   at_chikatetsu_akatsuka?
  #   at_heiwadai?
  #   at_hikawadai?
  #   at_kotake_mukaihara?
  #   at_senkawa?
  #   at_kanamecho?
  #   at_ikebukuro_on_yurakucho_or_fukutoshin_line?

  ::TokyoMetro::Modules::Common::Dictionary::Station::RegexpInfo.constants( false ).each do | const_name |
    base_method_name = const_name.to_s.downcase
    eval <<-DEF
      def at_#{ base_method_name }?
        station_same_as__is_in?( ::TokyoMetro::Modules::Common::Dictionary::Station::RegexpInfo.#{ base_method_name } )
      end

      #-------- [alias]
      alias :is_at_#{ base_method_name }? :at_#{ base_method_name }?
    DEF
  end

  #---------------- is_between_xxx?
  #---------------- is_at_xxx?
  # @note ::TokyoMetro::Modules::Common::Dictionary::Station::StringList を用いて定義

  # @example
  #   between_honancho_and_nakano_shimbashi_including_invalid?
  #   between_honancho_and_nakano_shimbashi?
  #   between_honancho_and_nakano_sakaue_including_invalid?
  #   between_honancho_and_nakano_sakaue?
  #   at_wakoshi_or_kotake_mukaihara?
  #   between_chikatetsu_narimasu_and_hikawadai?
  #   between_wakoshi_and_hikawadai?
  #   between_wakoshi_and_kotake_mukaihara?
  #   between_senkawa_and_kanamecho?
  #   between_wakoshi_and_kanamecho?
  #   between_wakoshi_and_ikebukuro?
  #   at_yurakucho_and_fukutoshin_common_station?
  #   at_namboku_and_toei_mita_line_common_station?

  ::TokyoMetro::Modules::Common::Dictionary::Station::StringList.constants( false ).map { | const_name |
    const_name.to_s.downcase
  }.delete_if { | base_method_name |
    /_in_system\Z/ === base_method_name
  }.each do | base_method_name |
    case base_method_name
    # between で始まる場合
    when /\Abetween_/
      defined_method_base_name = "#{ base_method_name }?"
    # common_stations で終わる場合
    when /common_stations\Z/
      defined_method_base_name = "at_" + base_method_name.gsub( /common_stations\Z/ , "common_station" ) + "?"
    # and が含まれる場合
    when /and/
      defined_method_base_name = "at_" + base_method_name.gsub( /and/ , "or" ) + "?"
    else
      next
    end

    eval <<-DEF
      def #{defined_method_base_name}
        station_same_as__is_in?( ::TokyoMetro::Modules::Common::Dictionary::Station::StringList.#{base_method_name} )
      end

      #-------- [alias]
      alias :is_#{defined_method_base_name} :#{defined_method_base_name}
    DEF

  end

  private

  def station_same_as__is_in?( *args , compared )
    compare_base( args , compared )
  end

end