class OnPageLoadHandler

  list = (v) ->

    ary = []

    document = new Document()
    ary.push document

    #---- concerns (1)

    railway_line_matrixes = new RailwayLineMatrixes()
    station_matrixes = new StationMatrixes()
    railway_line_codes = new RailwayLineCodes()

    ary.push railway_line_matrixes
    ary.push station_matrixes
    ary.push railway_line_codes

    #---- controllers

    railway_line = new RailwayLine()
    station_timetables = new StationTimetables()
    station_facility = new StationFacility()
    passenger_survey = new PassengerSurvey()
    fare_table = new FareTables()

    ary.push railway_line
    ary.push station_timetables
    ary.push station_facility
    ary.push passenger_survey
    ary.push fare_table

    train_operation_infos = new TrainOperationInfos()
    train_location_infos = new TrainLocationInfos()

    ary.push train_operation_infos
    ary.push train_location_infos

    #---- concerns (2)

    links_to_station_info_pages = new LinksToStationInfoPages()
    selection_header_processor = new SelectionHeaderProcessor()
    real_time_info_processor = new RealTimeInfoProcessor()
    twitters_processor = new TwittersProcessor()
    now_developing_processor = new NowDevelopingProcessor()
    problems_processor = new NowDevelopingProcessor( $( '#problems' ) )
    ul_side_menu_links = new UlSideMenuLinks()
    ul_station_related_links = new UlStationRelatedLinks()

    ary.push links_to_station_info_pages
    ary.push selection_header_processor
    ary.push real_time_info_processor
    ary.push twitters_processor
    ary.push now_developing_processor
    ary.push problems_processor
    ary.push ul_side_menu_links
    ary.push ul_station_related_links

    # 不使用
    # main_contents = new MainContents()
    # bottom_content = new BottomContent()

    # ary.push main_contents
    # ary.push bottom_content

    return ary

  process: ->
    $.each list(@) , ->
      @.process()
      return
    return

# Turbolinks 対策
# [NG] $ ->
# [NG] $( document ).live 'pageshow', ->
# [OK] $( document ).on 'ready page:load' , ->

$( document ).on 'ready page:load' , ->
  h = new OnPageLoadHandler()
  h.process()
  return