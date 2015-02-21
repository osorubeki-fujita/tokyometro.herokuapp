class TrainTypeDecorator < Draper::Decorator
  delegate_all

  def css_class_in_document
    object.same_as.gsub( regexp_for_css_class_in_document , "" ).gsub( /\./ , "_" ).underscore
  end
  
  private
  
  def regexp_for_css_class_in_document
    /\Acustom\.TrainType\:(?:[a-zA-Z]+)\.(?:[a-zA-Z]+)\./
  end

end