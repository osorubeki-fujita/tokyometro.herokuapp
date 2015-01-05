function changeAttibutesOfBoxesInTrainInformation( width_of_each_normal_railway_line ) {
  var train_information_domain = $( "#train_informations" ) ;
  // changeAttibutesOfLineMatrixDomainInTrainInformation( train_information_domain , width_of_each_normal_railway_line ) ;

  var width_and_height_of_status = determineWidthOfStatusInTrainInformation( train_information_domain ) ;
  var width_of_status = width_and_height_of_status[0] ;
  var height_of_status = width_and_height_of_status[1] ;

  train_information_domain.children().each( function() {
    var train_information = $( this );
    var status = train_information.children().eq(1) ;
    status.css( 'width' , width_of_status ) ;
    status.css( 'height' , height_of_status ) ;
  });
}

function changeAttibutesOfLineMatrixDomainInTrainInformation( train_information_domain , width_of_each_normal_railway_line ) {
  train_information_domain.children().each( function() {
    var train_information = $( this );
    var railway_line_matrix = train_information.children().eq(0) ;

    var railway_line_matrix_info_domain = railway_line_matrix.children().first() ;
    var railway_line_code_outer = railway_line_matrix_info_domain.children().eq(0) ;
    var railway_line_text = railway_line_matrix_info_domain.children().eq(1) ;

    changeAttibutesOfLineMatrixDomainInTrainInformationSub( railway_line_matrix , width_of_each_normal_railway_line , railway_line_matrix_info_domain , railway_line_code_outer , railway_line_text ) ;
    changeWidthAndMarginOfLineMatrixInfoDomain( width_of_each_normal_railway_line , railway_line_matrix_info_domain ) ;
  });
}

function changeAttibutesOfLineMatrixDomainInTrainInformationSub( railway_line_matrix , width_of_each_normal_railway_line , railway_line_matrix_info_domain , railway_line_code_outer , railway_line_text ) {
  var railway_line_matrix_info_padding_top_and_bottom = 4 ;
  var railway_line_matrix_info_height = Math.max( railway_line_code_outer.outerHeight( true ) , railway_line_text.outerHeight( true ) ) + railway_line_matrix_info_padding_top_and_bottom * 2 ;
  railway_line_matrix_info_domain.css( 'height' , railway_line_matrix_info_height ) ;
  railway_line_matrix.css( 'height' , railway_line_matrix_info_height ) ;
  railway_line_matrix.css( 'padding-top' , railway_line_matrix_info_padding_top_and_bottom ) ;
  railway_line_matrix.css( 'padding-bottom' , railway_line_matrix_info_padding_top_and_bottom ) ;
  railway_line_matrix.css( 'width' , width_of_each_normal_railway_line ) ;

  railway_line_matrix_info_domain.css( 'width' , Math.ceil( railway_line_code_outer.outerWidth( true ) + railway_line_text.outerWidth( true ) ) ) ;
}

function changeWidthAndMarginOfLineMatrixInfoDomain( width_of_each_normal_railway_line , railway_line_matrix_info_domain ) {
  var width_of_railway_line_matrix_info_domain = railway_line_matrix_info_domain.outerWidth( true ) ;
  var railway_line_matrix_info_domain_margin_left_and_right = Math.floor( ( width_of_each_normal_railway_line - width_of_railway_line_matrix_info_domain ) * 0.5 ) ;
  railway_line_matrix_info_domain.css( 'margin-left' , railway_line_matrix_info_domain_margin_left_and_right ) ;
  railway_line_matrix_info_domain.css( 'margin-right' , railway_line_matrix_info_domain_margin_left_and_right ) ;
}

function determineWidthOfStatusInTrainInformation( train_information_domain ) {
  var width_of_railway_line_matrix = 0 ;
  var height_of_railway_line_matrix = 0 ;
  train_information_domain.children().each( function() {
    width_of_railway_line_matrix = Math.max( width_of_railway_line_matrix , $( this ).children().eq(0).outerWidth( true ) ) ;
    height_of_railway_line_matrix = Math.max( height_of_railway_line_matrix , $( this ).children().eq(0).innerHeight() ) ;
  });
  var width_of_status = train_information_domain.innerWidth() - width_of_railway_line_matrix - 2 ;
  var height_of_railway_line_matrix = height_of_railway_line_matrix ;
  return [ width_of_status , height_of_railway_line_matrix ] ;
}