class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::GinzaLine < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::OneRailwayLine

  private

  def additional_info_bottom
    ::Proc.new {
      h.render inline: <<-HAML , type: :haml , locals: { columns: columns }
%tr{ class: :additional_info_bottom }
  %td{ colspan: columns }
    %div{ class: :info }
      %div{ class: :icon }
        %h3{ class: :text_ja }<
          = "浅草駅のご案内"
        %h4{ class: :text_en }<
          = "Information of Asakusa Station"
    %div{ class: :contents }
      %div{ class: :content }
        %h5{ class: :text_ja }<
          = "都営浅草線へお乗り換えの方へ"
        %p{ class: :text_ja }<
          = "浅草駅1番線に到着する列車に乗車されるとお乗り換えが便利です。"
      %div{ class: :content }
        %h5{ class: :text_ja }<
          = "浅草雷門、浅草寺方面へお越しの方へ"
        %p{ class: :text_ja }<
          = "浅草駅2番線に到着する列車に乗車されると便利です。"
      HAML
    }
  end

end