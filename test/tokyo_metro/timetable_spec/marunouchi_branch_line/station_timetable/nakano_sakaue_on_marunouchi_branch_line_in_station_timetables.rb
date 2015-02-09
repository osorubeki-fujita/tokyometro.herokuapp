# 丸ノ内線支線各駅の駅時刻表 - 列車の行先の確認
# @note 方南町、中野富士見町、中野新橋からの「中野坂上行き」について
def nakano_sakaue_on_marunouchi_branch_line_in_station_timetables

  # 方南町、中野富士見町、中野新橋の時刻表を取得
  timetables_between_honancho_and_nakano_shimbashi = ::TokyoMetro::Api.station_timetables.select { | timetable |
    timetable.marunouchi_line_including_branch? and timetable.between_honancho_and_nakano_shimbashi?
  }

  # 方南町、中野富士見町、中野新橋のそれぞれの時刻表について
  timetables_between_honancho_and_nakano_shimbashi.each do | timetable |

    # 時刻表の列車情報のうち、中野坂上行きについて確認
    timetable.timetables.each do | t |
      t.each do | train |

        if /NakanoSakaue\Z/ === train.terminal_station
          # 正しい駅名は MarunouchiBranch.NakanoSakaue の形になっている
          valid_terminal_station_name = train.terminal_station.gsub( /Marunouchi(?:Branch)?\./ , "MarunouchiBranch." )

          describe ::TokyoMetro::Api::StationTimetable::Info::Train::Info , "bound for Nakano-sakaue on Marunouchi Branch Line" do
            it "should terminate at Nakano-sakaue on Marunouchi Branch Line." do
              expect( train.terminal_station ).to match( /MarunouchiBranch\.NakanoSakaue\Z/ )
              expect( train ).to be_terminate_at_nakano_sakaue
              expect( train ).to be_terminate_at_nakano_sakaue_on_marunouchi_branch_line
            end
          end
        end

      end
    end

  end

end