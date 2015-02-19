class TokyoMetro::Static::OperationDay::List < Array

  include ::TokyoMetro::ClassNameLibrary::Static::OperationDay
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::List

  def method_missing( method_name , *args )
    info = self.find { | item | item.match?( method_name ) }
    if info.present?
      return info
    else
      super( method_name , *args )
    end
  end

end