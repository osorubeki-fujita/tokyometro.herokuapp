namespace :temp do

  namespace :completed do

    task :railway_line_relations_20150727 => :environment do
      [
        [ "odpt.Railway:TokyoMetro.Marunouchi" , "odpt.Railway:TokyoMetro.MarunouchiBranch" ] ,
        [ "odpt.Railway:TokyoMetro.Chiyoda" , "odpt.Railway:TokyoMetro.ChiyodaBranch" ] ,
        [ "odpt.Railway:Seibu.Ikebukuro" , "odpt.Railway:Seibu.Toshima" ] ,
        [ "odpt.Railway:Seibu.Ikebukuro" , "odpt.Railway:Seibu.Sayama" ] ,
        [ "odpt.Railway:Seibu.Ikebukuro" , "odpt.Railway:Seibu.SeibuYurakucho" ] ,
        [ "odpt.Railway:Tobu.Skytree" , "odpt.Railway:Tobu.SkytreeOshiage" ] ,
        [ "odpt.Railway:Tobu.Nikko" , "odpt.Railway:Tobu.Kinugawa" ] ,
        [ "odpt.Railway:Keio.Keio" , "odpt.Railway:Keio.New" ]
      ].each do | main , branch |
        ::Railway::Line::Relation.create(
          main_railway_line_info_id: ::Railway::Line::Info.find_by( same_as: main ).id ,
          branch_railway_line_info_id: ::Railway::Line::Info.find_by( same_as: branch ).id
        )
      end
    end

  end

end
