module TokyoMetro::ApiModules::Decision::OperatedSection

  def only_in_marunouchi_branch_line?
    marunouchi_branch_line? and ( start_at_honancho? or start_at_nakano_fujimicho? or start_at_nakano_sakaue_on_marunouchi_branch_line? ) and ( terminate_at_honancho? or terminate_at_nakano_fujimicho? or terminate_at_nakano_sakaue_on_marunouchi_branch_line? )
  end

  def only_in_marunouchi_branch_line_including_invalid?
    marunouchi_line_including_branch? and ( start_at_honancho_including_invalid? or start_at_nakano_fujimicho_including_invalid? or start_at_nakano_sakaue_on_marunouchi_line_including_branch? ) and ( terminate_at_honancho_including_invalid? or terminate_at_nakano_fujimicho_including_invalid? or terminate_at_nakano_sakaue_on_marunouchi_line_including_branch? )
  end

  def only_in_chiyoda_branch_line?
    chiyoda_line? and ( ( start_at_kita_ayase? and terminate_at_ayase? ) or ( start_at_ayase? and terminate_at_kita_ayase? ) )
  end

end