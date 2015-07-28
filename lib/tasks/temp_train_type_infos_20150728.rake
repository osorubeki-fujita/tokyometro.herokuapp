namespace :temp do

  namespace :completed do

    #---- begin task
    task :train_type_infos_20150728 => :environment do

      train_type_infos = ::Train::Type::Info.all.to_a

      #---- begin loop
      for i in 0..( train_type_infos.length - 1 )
        train_type_info = train_type_infos[i]
        note = train_type_info.note

        regexp = /[（【](.+)[】）]\Z/

        if regexp =~ note
          notes_in_parentheses = $1.split( /／/ )
          note_main = note.gsub( regexp , "" )
        else
          note_main = note
          notes_in_parentheses = nil
        end

        note_info = ::Train::Type::Note::Info.find_or_create_by(
          info_id: train_type_info.id ,
          text_id: ::Train::Type::Note::Text.find_or_create_by( text_ja: note_main ).id
        )

        if notes_in_parentheses.present?
          #---- begin each
          notes_in_parentheses.each.with_index(1) do | str , i |

            if /直通/ =~ str
              additional_text = nil
            elsif /運行/ =~ str
              additional_text = nil
            elsif /停車/ =~ str
              additional_text = nil
            else
              additional_text = ::Train::Type::Note::Additional::Text.find_or_create_by( text_ja: str )
            end

            if additional_text.present?
              ::Train::Type::Note::Additional::Info.find_or_create_by( info_id: train_type_info.id , additional_text_id: additional_text.id , index: i )
            end

          end
          #---- end each

        end
      end
      #---- end loop

    end
    #---- end task

  end

end
