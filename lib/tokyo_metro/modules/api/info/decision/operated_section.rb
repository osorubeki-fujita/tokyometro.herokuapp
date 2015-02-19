module TokyoMetro::Modules::Api::Info::Decision::OperatedSection

  # @!group 運転区間に関するメソッド

  def operated_only_on_marunouchi_branch_line?
    # marunouchi_branch_line?
    #   and ( start_at_honancho? or start_at_nakano_fujimicho? or start_at_nakano_sakaue_on_marunouchi_branch_line? )
    #   and ( terminate_at_honancho? or terminate_at_nakano_fujimicho? or terminate_at_nakano_sakaue_on_marunouchi_branch_line? )

    marunouchi_branch_line? and start_on_marunouchi_branch_line? and terminate_on_marunouchi_branch_line?
  end

  def operated_only_on_marunouchi_branch_line_including_invalid?
    # marunouchi_line_including_branch?
    #   and ( start_at_honancho_including_invalid? or start_at_nakano_fujimicho_including_invalid? or start_at_nakano_sakaue_on_marunouchi_line_including_branch? )
    #   and ( terminate_at_honancho_including_invalid? or terminate_at_nakano_fujimicho_including_invalid? or terminate_at_nakano_sakaue_on_marunouchi_line_including_branch? )

    marunouchi_line_including_branch? and start_on_marunouchi_branch_line_including_invalid? and terminate_on_marunouchi_branch_line_including_invalid?
  end

  def operated_only_on_chiyoda_branch_line?
    chiyoda_branch_line? and ( ( start_at_kita_ayase_on_chiyoda_branch_line? and terminate_at_ayase_on_chiyoda_branch_line? ) or ( start_at_ayase_on_chiyoda_branch_line? and terminate_at_kita_ayase_on_chiyoda_branch_line? ) )
  end

  def operated_only_on_chiyoda_branch_line_including_invalid?
    ( chiyoda_line? or chiyoda_branch_line? ) and ( ( start_at_kita_ayase? and terminate_at_ayase? ) or ( start_at_ayase? and terminate_at_kita_ayase? ) )
  end

  #-------- [alias]
  [
    :marunouchi_branch_line ,
    :marunouchi_branch_line_including_invalid ,
    :chiyoda_branch_line ,
    :chiyoda_branch_line_including_invalid
  ].each do | method_base_name |
    [ :only , :is_operated_only_on , :only_on , :is_only_on ].each do | prefix |
      eval <<-ALIAS
        alias :#{ prefix }_#{ method_base_name }? :operated_only_on_#{ method_base_name }?
      ALIAS
    end
  end

  def marunouchi_main_and_branch_line?
    marunouchi_line_including_branch? and !( operated_only_on_marunouchi_branch_line? ) and ( starting_on_marunouchi_branch_line? or terminating_on_marunouchi_branch_line? ) and !( starting_at_nakano_sakaue? ) and !( terminate_at_nakano_sakaue? )
  end

  [ :is , :is_on , :is_operated_on , :operated_on , :on ].each do | prefix |
    eval <<-ALIAS
      alias :#{ prefix }_marunouchi_main_and_branch_line? :marunouchi_main_and_branch_line?
    ALIAS
  end

  # @!endgroup

end