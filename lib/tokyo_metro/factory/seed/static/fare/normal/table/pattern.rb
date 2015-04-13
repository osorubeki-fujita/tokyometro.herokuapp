class TokyoMetro::Factory::Seed::Static::Fare::Normal::Table::Pattern < TokyoMetro::Factory::Seed::Api::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Static::Fare
  include ::TokyoMetro::Factory::Seed::Static::Fare::Normal::Table::Common

  private

  def method_name_for_db_instance_class
    :db_instance_class_of_normal_table_pattern
  end

  def hash_to_db
    h = {
      date_of_revision: @date_of_revision ,
      operator_id: @operator_id
    }

    [ :ticket_fare , :child_ticket_fare , :ic_card_fare , :child_ic_card_fare ].each do | column_name |
      h[ column_name ] = @info.send( column_name )
    end

    h
  end

end