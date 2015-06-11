namespace :log do

  namespace :search do

    desc "Search log of JSON Error"
    task :json_error => :environment do
      ::LogFinder.search_by( /A JSON text must at least contain two octets/ )
    end

  end

end
