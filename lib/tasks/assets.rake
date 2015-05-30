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
end