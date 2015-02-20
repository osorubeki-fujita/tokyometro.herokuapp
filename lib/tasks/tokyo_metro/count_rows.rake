namespace :tokyo_metro do
  desc "コードの行数の取得"
  task :count_rows do
    files = [
=begin
      "#{ ::Rails.root }/../rails_tokyo_metro_dev/tsukaisute/**/**.rb" ,
      "#{ ::Rails.root }/../rails_tokyo_metro_db/**.txt" ,
      "#{ ::Rails.root }/../rails_tokyo_metro_db/additional_datas/**/**.yaml" ,
      "#{ ::Rails.root }/../rails_tokyo_metro_db/dictionary/**/**.yaml" ,
      "#{ ::Rails.root }/app/**/**.rb" ,
      "#{ ::Rails.root }/app/**/**.haml" ,
      "#{ ::Rails.root }/app/**/**.scss" ,
      "#{ ::Rails.root }/app/**/**.js" ,
      "#{ ::Rails.root }/db/seeds.rb" ,
      "#{ ::Rails.root }/db/seeds/**/**.rb" ,
      "#{ ::Rails.root }/lib/**/**.rb" ,
      "#{ ::Rails.root }/lib/**/**.yaml" ,
      "#{ ::Rails.root }/lib/**/**.rake" ,
      "#{ ::Rails.root }/test/tokyo_metro/**/**.rb" ,
      "#{ ::Rails.root }/config/application.rb" ,
      "#{ ::Rails.root }/config/application/**/**.rb" ,
      "#{ ::Rails.root }/Rakefile"
=end
      "#{ ::Rails.root }/app/helpers/**/**.rb" ,
    ].map { | str | Dir.glob( str ) }.flatten.sort
    ary_of_row_info = ::Array.new

    all_rows = 0

    files.each do | filename |
      file_content = open( filename , "r:utf-8" ).read.split( /\n/ ).delete_if { | row | /\A +end\Z/ === row or /\A *\Z/ === row }
      rows = file_content.length
      all_rows += rows
      ary_of_row_info << { filename: filename , rows: rows }
    end

    ary_of_row_info.sort_by { | item | item[ :rows ] }.each do | row_info |
      i = 108
      str = row_info[ :filename ] + " " + "." * [ 0 , ( i - row_info[ :filename ].length ) ].max + " " + row_info[ :rows ].to_s.rjust(4)
      puts str
    end
    puts ""
    puts "#{ files.length} files, #{ all_rows } rows"
  end
end