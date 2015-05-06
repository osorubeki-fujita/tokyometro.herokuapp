class Initializer

  process: ->
    top_content = new TopContent()
    document = new Document()

    railway_line_matrixes = new RailwayLineMatrixes()
    station_matrixes = new StationMatrixes()
    railway_line_codes = new RailwayLineCodes()

    railway_line = new RailwayLine()
    station_timetables = new StationTimetables()
    station_facility = new StationFacility()
    passenger_survey = new PassengerSurvey()
    fare_table = new FareTables()

    train_informations = new TrainInformations()
    train_locations = new TrainLocations()

    links_to_station_info_pages = new LinksToStationInfoPages()
    selection_header_processor = new SelectionHeaderProcessor()
    real_time_info_processor = new RealTimeInfoProcessor()
    twitters_processor = new TwittersProcessor()

    now_developing_processor = new NowDevelopingProcessor()
    ul_side_menu_links = new UlSideMenuLinks()
    ul_station_related_links = new UlStationRelatedLinks()

    main_contents = new MainContents()

    # 不使用
    # bottom_content = new BottomContent()

    #--------

    top_content.process()
    document.process()

    railway_line_matrixes.process()
    station_matrixes.process()
    railway_line_codes.process()

    railway_line.process()
    station_timetables.process()
    station_facility.process()
    passenger_survey.process()
    fare_table.process()

    train_informations.process()
    train_locations.process()

    # console.log '\#--------'
    # console.log 'Initializer\#process (1)'
    links_to_station_info_pages.process()
    # console.log 'Initializer\#process (2)'
    selection_header_processor.process()
    real_time_info_processor.process()
    twitters_processor.process()

    now_developing_processor.process()
    ul_side_menu_links.process()
    ul_station_related_links.process()

    main_contents.process()

    # 不使用
    # bottom_content.process()

    return

window.Initializer = Initializer