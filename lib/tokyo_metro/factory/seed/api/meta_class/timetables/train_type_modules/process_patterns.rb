module TokyoMetro::Factory::Seed::Api::MetaClass::Timetables::TrainTypeModules::ProcessPatterns

  extend ::ActiveSupport::Concern

  private

  # @!group クラスインスタンス変数を操作するためのインスタンスメソッド

  def add_pattern( train_type_id )
    self.class.add_pattern( self.class.train_type_pattern_class.new( train_type_id , *( self.to_a ) ) )
  end

  def pattern
    self.class.get_pattern( *( self.to_a ) )
  end

  # @!endgroup

  module ClassMethods

    def train_type_pattern_class
      ::TokyoMetro::Factory::Seed::Api::MetaClass::Timetables::TrainType::Pattern
    end

    # @!group クラスインスタンス変数を操作するためのクラスメソッド

    def add_pattern( pattern )
      @patterns.unshift( pattern )
    end

    def get_pattern( *variables )
      @patterns.find { | item | item.match?( *variables ) }
    end

    # @!endgroup

  end

end