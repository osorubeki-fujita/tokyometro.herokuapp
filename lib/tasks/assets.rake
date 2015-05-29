namespace :assets do
  namespace :sass do
    namespace :make do

      #--------

      desc "Make partial sass files from .scss.erb files"
      task :partial do

        erb_dir = "#{ ::Rails.root }/app/assets/sass-partial-erbs"
        style_sheet_dir = "#{ ::Rails.root }/app/assets/stylesheets"
        erb_files = ::Dir.glob( "#{ erb_dir }/**/**.scss.erb" )
        puts erb_files
        erb_files.each do | filepath |
          scss_filepath = filepath.gsub( erb_dir , style_sheet_dir ).gsub( /\.erb\Z/ , "" )
          erb = ::ERB.new( ::File.open( filepath , "r:utf-8" ).read )
          erb.filename = filepath
          scss_content = erb.result.gsub( /^ +$/ , "" ).gsub( /\n+/ , "\n" ).gsub( /\A\n+/ , "" )

          ::FileUtils.mkdir_p( ::File.dirname( scss_filepath ) )
          ::File.open( scss_filepath , "w:utf-8" ) do |f|
            f.print( scss_content )
          end

        end

      end

      #--------

    end
  end
end