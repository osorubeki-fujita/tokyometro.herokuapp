namespace :assets do
  namespace :sass do

    namespace :make do

      #--------

      desc "Make partial sass files from .scss.erb files"
      task :partial do
        ::TokyoMetro.set_rails_consts
        ::TokyoMetro::Rake::Assets::Sass::Make.partial
      end

      #--------

    end

  end
  
  namespace :image do
    namespace :copy do

      desc "Copy svg files"
      task :svg_files => :environment do
        ::TokyoMetro::Rake::Assets::Image::SvgFiles.copy
      end

    end
  end

end
