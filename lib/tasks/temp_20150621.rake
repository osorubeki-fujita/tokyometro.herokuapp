namespace :temp do

  task :bug_fix_of_surrounding_area_name_20150621 => :environment do
    invalid = ::SurroundingArea.find_by( name_ja: " 都電荒川線鬼子母神前停留場" )
    if invalid.present?
      invalid.update( name_ja: "都電荒川線鬼子母神前停留場" )
    end
  end

end
