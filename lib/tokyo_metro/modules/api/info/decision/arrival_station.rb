module TokyoMetro::Modules::Api::Info::Decision::ArrivalStation

  include ::TokyoMetro::Modules::Common::Info::Decision::ArrivalStation

  private

  def arrival_at?( *args , compared: @arrival_station )
    raise if args.empty?
    super( *args , compared )
  end

  alias :is_arrival_at? :arrival_at?
  alias :arrive_at? :arrival_at?

end