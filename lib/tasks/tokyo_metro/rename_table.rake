namespace :tokyo_metro do
  namespace :check_namespaces do

    desc "名前空間の名称のチェック"
    task :rename_table do
      MatchedRow = Struct.new( :filename , :row , :row_number )
      filenames = ::Array.new

      filenames  << Dir.glob( "#{ ::Rails.root }/app/**/**.rb" )
      filenames  << Dir.glob( "#{ ::Rails.root }/app/**/**.haml" )
      filenames  << Dir.glob( "#{ ::Rails.root }/db/schema.rb" )
      filenames  << Dir.glob( "#{ ::Rails.root }/lib/tokyo_metro/**/**.rb" )
      # filenames  << Dir.glob( "#{ ::Rails.root }/../rails_tokyo_metro_db/**/**.yaml" )

      filenames = filenames.flatten
      namespaces = ARGV[1..-1]
      namespaces.each do | namespace |
        matched_rows = ::Array.new
        regexp_list = ::Array.new

        # regexp_list << /#{namespace}(?:Decorator)?(?: |\.|\Z)/

        regexp_list << /(?:#{namespace}(?:Decorator)?|#{namespace.underscore}|#{namespace.underscore.pluralize})(?: |\.|\Z)/
        regexp_list << /\"(?:#{namespace}(?:Decorator)?|#{namespace.underscore}|#{namespace.underscore.pluralize})(?:_id)?\"/

        # regexp_list << /(?:#{namespace}(?:Decorator)?|#{namespace.underscore}|#{namespace.underscore.pluralize})(?: |\.|\:|\Z)/
        # regexp_list << /\"(?:#{namespace}(?:Decorator)?|#{namespace.underscore}|#{namespace.underscore.pluralize})(?:_id)?\"/

        filenames.each do | filename |
          open( filename , "r:UTF-8" ).read.split( "\n" ).each.with_index(1) do | row , row_number |
            if regexp_list.any? { | regexp | regexp =~ row }
              matched_rows << MatchedRow.new( filename , row , row_number )
            end
          end
        end

        puts "-" * 64
        puts ""
        puts "● #{namespace}"
        puts ""
        filename_length_max = matched_rows.map { | matched_row | matched_row[ :filename ].length }.max
        if filename_length_max.present?
          filename_length_max += 4
        end
        matched_rows.each do | matched_row |
          puts "#{ matched_row[ :filename ].ljust( filename_length_max ) } #{ matched_row[ :row_number ].to_s.rjust(4) } - #{ matched_row[ :row ].gsub( /\A +/ , "" ) }"
        end
        puts ""
        number_of_files = matched_rows.map { | matched_row | matched_row[ :filename ] }.uniq.length
        puts "#{ number_of_files } files , #{ matched_rows.length } rows"
        puts ""
      end
    end
  end
end