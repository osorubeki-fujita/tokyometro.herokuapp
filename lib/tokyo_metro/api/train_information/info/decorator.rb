class TokyoMetro::Api::TrainInformation::Info::Decorator < TokyoMetro::Api::MetaClass::RealTime::Info::Decorator

  def initialize( request , obj , railway_line , max_delay , controller )
    super( request , obj )
    @railway_line = railway_line
    @max_delay = max_delay.try( :floor )
    @status_type = set_status_type
    @controller = controller
  end

  attr_reader :railway_line
  attr_reader :max_delay
  attr_reader :status_type
  attr_reader :controller

  def additional_info_abstruct_ja
    object.train_information_status.try( :name_ja_for_display )
  end

  def additional_info_abstruct_en
    object.train_information_status.try( :name_en_for_display )
  end

  def additional_info_precise_ja
    case @status_type
    when :after_last_train_finished
      "本日の運行は終了しました。"
    when :before_first_train_begin
      "運行開始までお待ち下さい。"
    when :no_train
      "運行中の列車はありません。"
    else
      object.text_in_api
    end
  end

  def additional_info_precise_en
    case @status_type
    when :after_last_train_finished
      "Today's operation was finished."
    when :before_first_train_begin
      "Please wait for the first train."
    when :no_train
      "No train is operated now."
    else
      object.text_en
    end
  end

  def status_text_ja
    case status_type
    when :no_train , :after_last_train_finished , :before_first_train_begin
      "運行中の列車 なし"
    when :on_schedule
      "平常運転"
    when :nearly_on_schedule
      "ほぼ平常運転"
    when :delayed
      "遅れあり"
    when :suspended
      "運転見合わせ"
    when :other_status
      "お知らせ"
    end
  end

  def status_text_en
    case status_type
    when :no_train , :after_last_train_finished , :before_first_train_begin
      "No train is operated now."
    when :on_schedule
      "Now on schedule"
    when :nearly_on_schedule
      "Now on schedule"
    when :delayed
      "Delayed"
    when :suspended
      "Operation suspended"
    when :other_status
      "Information"
    end
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: [ :train_information , :railway_line ] }
  = this.railway_line.decorate.render_matrix( make_link_to_railway_line: true , size: :small , link_controller_name: this.controller )
  %div{ class: [ :status , this.status_type ] }
    %div{ class: :infos }
      = this.render_status_icon_and_text
      = this.render_status_additional_infos
    HAML
  end

  def render_status_icon_and_text
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :icon }<
  = ::TokyoMetro::App::Renderer::Icon.send( this.status_type , request , 3 ).render
%div{ class: :text }
  %p{ class: :text_ja }<
    = this.status_text_ja
  %p{ class: :text_en }<
    = this.status_text_en
    HAML
  end

  def render_status_additional_infos
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
- max_delay_decorator = this.max_delay_instance.decorate( request )
%div{ class: :additional_infos }<
  - if [ this.additional_info_abstruct_ja , max_delay_decorator.displayed_in_train_information? , this.additional_info_precise_ja ].any?( &:present? )
    %div{ class: :text_ja }
      - if this.additional_info_abstruct_ja.present?
        %p{ class: :abstruct }<
          = this.additional_info_abstruct_ja
      - if max_delay_decorator.try( :displayed_in_train_information? )
        = max_delay_decorator.render_ja_in_train_information
      - if this.additional_info_precise_ja.present?
        %p{ class: :precise }<
          = this.additional_info_precise_ja
  - if [ this.additional_info_abstruct_en , max_delay_decorator.displayed_in_train_information? , this.additional_info_precise_en ].any?( &:present? )
    %div{ class: :text_en }
      - if this.additional_info_abstruct_en.present?
        %p{ class: :abstruct }<
          = this.additional_info_abstruct_en
      - if max_delay_decorator.displayed_in_train_information?
        = max_delay_decorator.render_en_in_train_information
      - if this.additional_info_precise_en.present?
        %p{ class: :precise }<
          = this.additional_info_precise_en
    HAML
  end

  def render_precise_version
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: [ :train_information_precise_version , :railway_line ] }
  = this.railway_line.decorate.render_matrix( make_link_to_railway_line: true , size: :small , link_controller_name: :train_information )
  %div{ class: [ :status , this.status_type ] }
    %div{ class: :infos }
      = this.render_main_info_of_precise_version
      = this.render_time_of_origin_of_precise_version
      = this.render_dc_date_of_precise_version
      = this.render_validity_of_precise_version
      = this.render_operator_of_precise_version
    HAML
  end

  def render_main_info_of_precise_version
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
- max_delay_decorator = this.max_delay_instance.decorate
%div{ class: :main_info }
  - train_information_status = this.object.train_information_status
  - train_information_text = this.object.train_information_text
  - if train_information_status.present?
    %div{ class: :status_of_precise_version }<
      = train_information_status.name_ja_for_display
  %div{ class: :text_of_precise_version }<
    = train_information_text.in_api
  = max_delay_decorator.render_in_train_information_precise_version
    HAML
  end

  def render_time_of_origin_of_precise_version
    if object.time_of_origin.present?
      render_info_of_precise_version( "発生時刻" , :time_of_origin , :time , object.time_of_origin.to_strf_normal_ja )
    end
  end

  def render_operator_of_precise_version
    render_info_of_precise_version( "運行事業者" , :operator_name , :name , ::Operator.find_by( same_as: object.operator ).name_ja )
  end

  def max_delay_instance
    ::TokyoMetro::Api::TrainLocation::Info::Delay.new( @max_delay )
  end

  private

  def no_train?
    @max_delay.blank?
  end

  def on_schedule?
    object.on_schedule? and @max_delay < 10
  end

  def nearly_on_schedule?
    object.on_schedule? and @max_delay >= 10 and @max_delay < 180
  end

  def delayed?
    # object.delayed? or @max_delay >= 180
    @max_delay >= 180
  end

  def suspended?
    object.suspended?
  end

  def set_status_type
    if no_train?
      case object.dc_date.hour
      when 20 , 21 , 22 , 23 , 0 , 1 , 2
        :after_last_train_finished
      when 3 , 4 , 5 , 6
        :before_first_train_begin
      else
        :no_train
      end
    elsif on_schedule?
      :on_schedule
    elsif nearly_on_schedule?
      :nearly_on_schedule
    elsif delayed?
      :delayed
    elsif suspended?
      :suspended
    else
      :other_status
    end
  end

end