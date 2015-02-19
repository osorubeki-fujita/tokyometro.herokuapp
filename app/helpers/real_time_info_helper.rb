module RealTimeInfoHelper

  def time_infos( time_now , last_update , next_update )
    time_info( "データ取得時刻" , time_now ) + time_info( "最終更新日時" , last_update ) + time_info( "次回更新予定" , next_update )
  end

    private

    def time_info( title , time )
      content_tag( :div , class: :time_info ) do
        concat content_tag( :div , title , class: :title )
        concat content_tag( :div , time.strftime( format_for_real_time_info ) , class: :time )
      end
    end

    def format_for_real_time_info
      "%Y年%m月%d日 %H:%M:%S"
    end

end

__END__

<%= escape_javascript( time_infos( @time_now , @last_update , @next_update ) ) %>


<%# = escape_javascript( time_infos( @time_now , @last_update , @next_update ) ) %>