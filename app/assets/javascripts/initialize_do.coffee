initializeDo = ->
  top_content = new TopContent()
  document = new Document()
  railway_line_and_station_matrix = new RailwayLineAndStationMatrix()
  railway_line_codes = new RailwayLineCodes()
  railway_line = new RailwayLine()
  station_timetables = new StationTimetables()
  station_facility = new StationFacility()
  passenger_survey_table = new PassengerSurveyTable()
  main_contents = new MainContents()

  # 不使用
  # bottom_content = new BottomContent()

  #--------

  top_content.process()
  document.process()
  railway_line_and_station_matrix.process()
  railway_line_codes.process()
  railway_line.process()
  station_timetables.process()
  station_facility.process()
  passenger_survey_table.process()
  main_contents.process()

  # 不使用
  # bottom_content.process()
  return

window.initializeDo = initializeDo