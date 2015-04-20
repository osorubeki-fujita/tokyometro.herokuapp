class TokyoMetro::App::Renderer::StationFacility::Platform::Info::MetaClass::TableRow::MetaClass < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , infos_in_a_row )
    super( request )
    @infos_in_a_row = infos_in_a_row

    set_proc_for_display
    set_proc_for_dicision
  end

  def render
    ary = ::Array.new

    @current_index = 0
    while @current_index <= last_index_of_infos_in_a_row
      info_in_this_cell = @infos_in_a_row[ @current_index ]
      if info_in_this_cell.blank?
        ary << nil
        @current_index += 1
      else
        _number_of_connected_cells = number_of_connected_cells
        ary << { infos: info_in_this_cell , number_of_connected_cells: number_of_connected_cells , proc_for_display: @proc_for_display }
        @current_index += _number_of_connected_cells
      end
    end

    h.render inline: <<-HAML , type: :haml , locals: { ary: ary }
- ary.each do | element |
  - if element.blank?
    = ::StationFacilityPlatformInfoDecorator.render_an_empty_cell
  - else
    %td{ class: :present , colspan: element[ :number_of_connected_cells ] }<
      %ul
        - element[ :infos ].each do | info |
          %li<
            = element[ :proc_for_display ].call( info )
    HAML
  end

  private

  def last_index_of_infos_in_a_row
    @infos_in_a_row.length - 1
  end

  def set_proc_for_display
    @proc_for_display = ::Proc.new { | info | info.decorate.render }
  end

  def set_proc_for_dicision
    @proc_for_dicision = ::Proc.new { | infos | infos.map( &:id ) }
  end

  # 結合する cell の個数を取得するメソッド
  def number_of_connected_cells
    i_next = 1
    i_compared = @current_index + i_next

    while equal_to_next_cell?( i_compared )
      i_next += 1
      i_compared = @current_index + i_next
    end

    i_next
  end

  # 次のセルと内容が同一か否かを判定するメソッド
  # @note #number_of_connected_cells から呼び出す
  def equal_to_next_cell?( i_compared )
    info_in_i = @infos_in_a_row[ @current_index ]
    info_compared = @infos_in_a_row[ i_compared ]
    last_index = @infos_in_a_row.length - 1
    if @current_index < last_index and info_compared.present?
      @proc_for_dicision.call( info_in_i ) == @proc_for_dicision.call( info_compared )
    else
      false
    end
  end

end