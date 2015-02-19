# @note {TokyoMetro::Modules::Api::Convert::Customize::TrainTimetable::TrainRelationsOnMarunouchiBranchLine#.set_modules} により {::TokyoMetro::Api::TrainTimetable::Info} へ include される。
module TokyoMetro::Modules::Api::Convert::Customize::TrainTimetable::TrainRelationsOnMarunouchiBranchLine::Dictionary

  extend ::ActiveSupport::Concern

  [
    [ :train_relations , :train_relations_on_marunouchi_branch_line ] ,
    [ :starting_and_terminal_stations , :starting_and_terminal_stations_of_marunouchi_branch_line_train ]
  ].each do | filename , const_base_name |

    const_name = const_base_name.upcase

    const_set( const_name , ::YAML.load_file( "#{::TokyoMetro.dictionary_dir}/additional_infos/customize/train_timetable/marunouchi_branch_line/#{filename}.yaml" ) )

      eval <<-DEF
        module ClassMethods
          def #{ const_base_name }
            #{ const_name }
          end
        end
      DEF

  end

end