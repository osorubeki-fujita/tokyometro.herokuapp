#--------------------------------
# プラットホーム情報の処理
#--------------------------------

#-------- changeStationFacilityPlatformInfoTabByPageLink
#-------- ページ内のタブをクリックすることによる処理

changeStationFacilityPlatformInfoTabByPageLink = ( tab_id , change_location = true ) ->
  s = new StationFacilityPlatformInfoTabsAndContents()
  s.display_platform_info_tab_of_id( tab_id , change_location )
  return

window.changeStationFacilityPlatformInfoTabByPageLink = changeStationFacilityPlatformInfoTabByPageLink