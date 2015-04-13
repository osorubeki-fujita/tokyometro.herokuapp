module TimeInfoHelper

  def time_info( title , time )
    render inline: <<-HAML , type: :haml , locals: { title: title , time: time }
%div{ class: :time_info }
  %div{ class: :title }<
    = title
  %div{ class: :time }<
    = time.to_strf_normal_ja
    HAML
  end

end