class Operator::AdditionalInfo < ActiveRecord::Base

  belongs_to :info , class: ::Operator::Info
  belongs_to :color_info , class: ::Design::Color::Info
  belongs_to :railway_line_code_info , class: ::Operator::CodeInfo
  belongs_to :station_code_info , class: ::Operator::CodeInfo

  [ :railway_line , :station ].each do | type |
    [ :shape , :stroke_width , :text_weight , :text_size ].each do | column |

      eval <<-DEF
        def #{ type }_code_#{ column }
          #{ type }_code_info.#{ column }
        end
      DEF

    end
  end

end
