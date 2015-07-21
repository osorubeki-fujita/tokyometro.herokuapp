namespace :assets do
  namespace :sass do

    namespace :make do

      #--------

      desc "Make partial sass files from .scss.erb files"
      task :partial => :environment do
        ::TokyoMetro::Rake::Rails::Assets::Sass::Make.partial
      end

      #--------

    end

  end

  namespace :image do
    namespace :copy do

      desc "Copy svg files"
      task :svg_files => :environment do
        ::TokyoMetro::Rake::Rails::Assets::Image::SvgFiles.copy
      end

    end
  end

end
