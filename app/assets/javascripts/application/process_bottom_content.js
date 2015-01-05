//-------- bottom_content の操作
function processBottomContent() {
  var bottom_content = $( 'div#bottom_content' ) ;
  var links = bottom_content.children( '.links' ) ;
  var height_of_domain = bottom_content.outerHeight( true ) ;
  var margin_of_links = ( height_of_domain - getSumOuterHeight( links , true ) ) * 0.5 ;
  setCssAttributesToEachDomain( links , 'margin-top' , margin_of_links ) ;
  setCssAttributesToEachDomain( links , 'margin-bottom' , margin_of_links ) ;
}