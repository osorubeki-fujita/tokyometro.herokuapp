namespace :assets do

  namespace :make do
    namespace :sass do

      desc "Make partial sass files from .scss.erb files"
      task :from_erb => :environment do
        # @note
        # task is 'rake assets:make:sass:partial'
        # factory namespace is '... Assets::Sass::Make.partial'
        ::TokyoMetro::Rake::Rails::Assets::Sass::Make.from_erb_files( on: ::TokyoMetro::RAILS_DIR )
      end

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
