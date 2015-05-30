namespace :assets do
  namespace :sass do
    namespace :make do

      #--------

      desc "Make partial sass files from .scss.erb files"
      task :partial do
        ::TokyoMetro::Rake::Assets::Sass::Make.make_partial
      end

      #--------

    end
  end
end