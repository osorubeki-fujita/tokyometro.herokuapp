function processStationFacilityInfos() {
  var station_facility_info = $( '#station_facility_info' ) ;
  station_facility_info.children().each( function() {
    var content = $( this ) ; // escalator , elevator , toilet , ...
    setTitleHeightOfEachStationFacility( content ) ;
    setInsideAndOutsideDomain( content ) ;
    setAllOfUniformWidthToMax( content.find( '.operation_day' ) ) ;
    setAllOfUniformWidthToMax( content.find( '.service_time' ) ) ;
    setAllOfUniformWidthToMax( content.find( '.remark' ) ) ;
  });

  var domains_of_inside_and_outside = station_facility_info.find( '.inside , .outside' ) ;
  var title_width = getMaxOuterWidth( domains_of_inside_and_outside , true ) ;
  setCssAttributesToEachDomain( domains_of_inside_and_outside.find( '.title' ) , 'width' , title_width ) ;

  domains_of_inside_and_outside.each( function() {
    var margin_left = $( this ).marginLeft ;
    $( this ).css( 'margin-right' , 0 ) ;
    $( this ).css( 'width' , title_width - margin_left ) ;
  });
}

function setTitleHeightOfEachStationFacility( content ) {
  var title = content.children( '.title' ).first() ;
  var title_text_ja = title.children().eq(0) ;
  // var title_text_en = title.children().eq(1) ;

  // var title_height = Math.max( title_text_ja.height() , title_text_en.height() );
  // var title_text_ja_margin_top = title_height - title_text_ja.height() ;
  // var title_text_en_margin_top = title_height - title_text_en.height() ;
  var title_height = title_text_ja.height() ;

  // title_text_ja.css( 'margin-top' , title_text_ja_margin_top ) ;
  // title_text_en.css( 'margin-top' , title_text_en_margin_top ) ;
  title.css( 'height' , title_height ) ;
}

function setInsideAndOutsideDomain( content ) {
  var inside_and_outside = content.children( '.inside , .outside' ) ;
  inside_and_outside.each( function() {
    var domain = $( this ) ;
    setTitleHeightOfEachStationFacility( domain ) ;
  });

  inside_and_outside.children( '.facility' ).each( function() {
    var facility = $( this ) ;
    var number = facility.children().eq(0) ;
    var info = facility.children().eq(1) ;

    var service_details = info.children( '.service_details' ).first() ;
    service_details.children().each( function() {
      var service_detail = $( this ) ;

      var escalator_directions = service_detail.children( '.escalator_directions' ).first() ;
      escalator_directions.css( 'height' , getMaxOuterHeight( escalator_directions.children() , true ) ) ;

      service_detail.css( 'height' , getMaxOuterHeight( service_detail.children() , true ) ) ;
    });

    var toilet_assistants = info.children( '.toilet_assistants' ).first() ;
    toilet_assistants.css( 'height' , getMaxOuterHeight( toilet_assistants.children() , true ) ) ;
    
    var info_height = getSumOuterHeight( info.children() , true ) ;
    info.css( 'height' , info_height ) ;
    var facility_height = Math.max( number.outerHeight( true ) , info_height ) ;
    facility.css( 'height' , facility_height ) ;
  });

  var content_height = getSumOuterHeight( content.children() , true ) ;
  content.css( 'height' , content_height ) ;
}