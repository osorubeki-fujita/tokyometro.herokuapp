module PlatformInfoCellProcessHelper

  def platform_infos_conncet_cells_including_same_info_and_make_cells( infos , proc_for_display , proc_for_dicision = nil )
    if proc_for_dicision.nil?
      proc_for_dicision = Proc.new { | infos | infos.map( &:id ) }
    end

    i = 0
    while i <= infos.length - 1 do
      info_in_this_cell = infos[i]
      if info_in_this_cell.blank?
        concat platform_infos_make_an_empty_cell
        i += 1
      else
        connected_cells = platform_infos_number_of_connected_cells( infos , i , proc_for_dicision )
        concat platform_infos_make_a_cell_including_same_info( info_in_this_cell , connected_cells , proc_for_display )
        i += connected_cells
      end
    end
  end

  # 結合する cell の個数を取得するメソッド
  def platform_infos_number_of_connected_cells( infos , i , proc_for_dicision )
    i_next = 1
    i_compared = i + i_next

    while platform_infos_equal_to_next_cell?( infos , i , i_compared , proc_for_dicision )
      i_next += 1
      i_compared = i + i_next
    end

    i_next
  end

  # 次のセルと内容が同一か否かを判定するメソッド
  # @note #platform_infos_number_of_connected_cells から呼び出す
  def platform_infos_equal_to_next_cell?( infos , i , i_compared , proc_for_dicision )
    info_in_i = infos[ i ]
    info_compared = infos[ i_compared ]
    last_index = infos.length - 1
    if i < last_index and info_compared.present?
      proc_for_dicision.call( info_in_i ) == proc_for_dicision.call( info_compared )
    else
      false
    end
  end

  # 中身のないセルを作成するメソッド
  def platform_infos_make_an_empty_cell
    render inline: <<-HAML , type: :haml
%td{ class: :empty }<
  = " "
    HAML
  end

  # 中身のあるセルを作成するメソッド
  def platform_infos_make_a_cell_including_same_info( info_in_this_cell , connected_cells , proc_for_display )
    h_locals = { infos: info_in_this_cell , connected_cells: connected_cells , proc_for_display: proc_for_display }
    render inline: <<-HAML , type: :haml , locals: h_locals
- if connected_cells == 1
  %td{ class: :present }<
    = platform_infos_make_content_in_a_cell_including_same_info( infos , proc_for_display )
- else
  %td{ class: :present , colspan: connected_cells }<
    = platform_infos_make_content_in_a_cell_including_same_info( infos , proc_for_display )
    HAML
  end

  # 中身のあるセルの具体的な中身を記述するメソッド
  def platform_infos_make_content_in_a_cell_including_same_info( infos , proc_for_display )
    render inline: <<-HAML , type: :haml , locals: { infos: infos , proc_for_display: proc_for_display }
%ul
  - infos.each do | info |
    %li<
      = proc_for_display.call( info )
    HAML
  end

end