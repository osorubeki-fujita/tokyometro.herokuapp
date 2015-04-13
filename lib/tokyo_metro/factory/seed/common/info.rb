class TokyoMetro::Factory::Seed::Common::Info

  include ::TokyoMetro::Factory::Seed::Common::SetOptionalVariables

  def initialize( info , *args , get_id: false )
    @info = info
    set_optional_variables( args )
    @get_id = get_id
  end

  def seed
    seed_main
    seed_optional_infos
  end

  def self.process( *variables )
    self.new( *variables ).seed
  end

  private

  def hash_to_db
    raise "#{self.class.name}\##{__method__} is not defined yet."
  end

  def seed_main
    if @get_id
      @id = db_class.find_or_create_by( hash_to_db ).id
    else
      db_class.find_or_create_by( hash_to_db )
    end
  end

  def seed_optional_infos
    nil
  end

  def db_class
    self.class.send( method_name_for_db_instance_class )
  end

  def method_name_for_db_instance_class
    :db_instance_class
  end

end