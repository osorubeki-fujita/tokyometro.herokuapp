class TrainTypeDecorator < Draper::Decorator
  delegate_all

  def css_class_in_document
    object.same_as.gsub( regexp_for_css_class_in_document , "" ).gsub( /\./ , "_" ).underscore
  end

  def render_in_station_timetable
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :train_type }<>
  = info.train_type_in_api.name_ja
    HAML
  end
  
  private
  
  def regexp_for_css_class_in_document
    /\Acustom\.TrainType\:(?:[a-zA-Z]+)\.(?:[a-zA-Z]+)\./
  end

end