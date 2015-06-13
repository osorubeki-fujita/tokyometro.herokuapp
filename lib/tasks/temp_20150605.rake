namespace :temp do

  #-------- ConnectingRailwayLine::Note

  task :connecting_railway_line_note_20150605 => :environment do
    info = ::ConnectingRailwayLine::Note.find_by( ja: "銀座線から東急東横線へ乗り換える場合は、表参道駅で半蔵門線に乗り換えの上、渋谷駅で半蔵門線から副都心線に乗り換えると移動距離が少なく便利です。" )
    raise "Error" unless info.present?
    info.update( ja: "銀座線から東急東横線へ乗り換える場合は、表参道駅で半蔵門線に乗り換えの上、渋谷駅で半蔵門線から東急東横線に乗り換えると移動距離が少なく便利です。" )
  end

  #-------- TrainOperation::Text

  task :reset_train_operation_text_id_20150605 => :environment do
    ::TrainOperation::Text.all.to_a.each.with_index(1) do | item , i |
      unless item.id == i
        item.update( id: i )
      end
    end
  end

end
