# @todo こちらを残す
module TokyoMetro::Factory::Scss::TrainType

  def self.make
    train_types = ::TrainType.all.map { | train_type | train_type }.delete_if { | train_type |
      train_type.color.nil? or train_type.bgcolor.nil?
    }.sort_by( &:railway_line_id )

    filename_of_color = "#{ dir_of_stylesheets }/common_mixins/color/rails/_train_types.scss"
    puts filename_of_color
    File.open( filename_of_color , "w:utf-8" ) do |f|
      f.print( content_common_mixin_color( train_types ) )
    end

    filename_of_main_content = "#{ dir_of_stylesheets }/tokyo_metro/controllers/concern/train_types.scss"
    puts filename_of_main_content
    File.open( filename_of_main_content , "w:utf-8" ) do |f|
      f.print( main_content_document_train_type( train_types ) )
    end
  end

  class << self

    private

    def scss_charset
      "\@charset \"utf-8\";"
    end

    def dir_of_stylesheets
      ::File.expand_path( "#{ ::TokyoMetro.top_dir }/app/assets/stylesheets" )
    end

    def content_common_mixin_color( train_types )
      ary = ::Array.new
      ary << scss_charset
      ary << ""
      train_types.each do | train_type |
        ary << color_variable_of_train_type( train_type ) + ": #{train_type.color}" + ";"
      end
      ary << ""
      train_types.each do | train_type |
        ary << bgcolor_variable_of_train_type( train_type ) + ": #{train_type.bgcolor}" + ";"
      end
      ary.join( "\n" )
    end

    def main_content_document_train_type( train_types )
      ary = ::Array.new
      indent = 2

      ary << scss_charset
      ary << ""
      ary << "\@import \'train_types/box.scss\' \;"
      ary << "\@import \'train_types/odakyu_romance_car.scss\' \;"
      ary << ""

      ary << "\#train_types \{"

      train_types_grouped_by_operator = train_types.group_by { | train_type |
        # 事業者ごとに分類（railway_line_id をもとに事業者名を取得する）
        train_type.railway_line.operator.id
      }
      train_types_grouped_by_operator.keys.sort.each do | operator_id |
        operator_instance = ::Operator.find_by( id: operator_id )
        train_types_in_an_operator = train_types_grouped_by_operator[ operator_id ]
        ary << begin_scss_content( ".#{ operator_instance.css_class_name }" , indent , 1 )

        train_types_grouped_by_railway_line = train_types_in_an_operator.group_by { | train_type |
          # 路線ごとに分類（railway_line_id をもとに路線名を取得する）
          train_type.railway_line.id
        }
        train_types_grouped_by_railway_line.keys.sort.each do | railway_line_id |
          railway_line_in_db = ::RailwayLine.find_by( id: railway_line_id )
          train_types_in_a_railway_line = train_types_grouped_by_railway_line[ railway_line_id ]
          raise "Error: #{operator_instance.same_as} - The railway line \##{railway_line_id} is not defined." if railway_line_in_db.nil?
          ary << begin_scss_content( ".#{ railway_line_in_db.css_class_name }" , indent , 2 )

          # 路線ごとの各種別について記述
          train_types_in_a_railway_line.each do | train_type |
            # custom.TrainType:x.y.z の z の部分をクラス名に用いる
            train_type_fundamental = ::DocumentHelper.train_type_css_class_in_document( train_type )

            ary << begin_scss_content( "\.#{train_type_fundamental}" , indent , 3 )

              ary << " " * indent * 4 + "\$color: " + color_variable_of_train_type( train_type ) + ";"
              ary << " " * indent * 4 + "\$bgcolor: " + bgcolor_variable_of_train_type( train_type ) + ";"
              ary << " " * indent * 4 + "\@include gradationSettingsOfTrainTypeBox( \$color , \$bgcolor ) ;"
              ary << " " * indent * 4 + "\@extend %trainTypeBoxBase_normal ;"

            ary << end_scss_content( indent , 3 )
          end

          ary << end_scss_content( indent , 2 )
        end
        ary << end_scss_content( indent , 1 )
      end
      ary << "\}"

      ary.join( "\n" )
    end

    def begin_scss_content( content , indent , i )
      " " * indent * i + content + " \{"
    end

    def end_scss_content( indent , i )
      " " * indent * i + "\}"
    end

    def train_type_rounded_square_class_name
      "train_type_box"
    end

    def color_variable_of_train_type( train_type )
      "$#{train_type.css_class_name}_color"
    end

    def bgcolor_variable_of_train_type( train_type )
      "$#{train_type.css_class_name}_bgcolor"
    end

  end

end