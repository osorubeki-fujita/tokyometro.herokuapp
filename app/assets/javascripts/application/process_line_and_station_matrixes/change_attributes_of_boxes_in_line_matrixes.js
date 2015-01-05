// "#railway_line_matrixes" の処理
function changeAttributesOfBoxesInLineMatrixes(
  selector_for_railway_line_matrixes ,
  normal_railway_lines , special_railway_lines ,
  width_of_each_normal_railway_line ,
  width_of_special_railway_lines_in_railway_line_matrixes ,
  lineDivision ,
  number_of_special_railway_lines ,
  outer_height_of_each_line , width_of_border ) {

  // 一般路線の box の設定
  changeAttributesOfNormalLineBoxes( normal_railway_lines , width_of_each_normal_railway_line ) ;

  // 特殊な路線（「有楽町線・副都心線」を想定）の box の設定
  changeAttributesOfSpecialLineBoxes( special_railway_lines , width_of_special_railway_lines_in_railway_line_matrixes ) ;

  // #railway_line_matrixes の高さの設定
  setHeightOfLineMatrixes( selector_for_railway_line_matrixes , normal_railway_lines , lineDivision , number_of_special_railway_lines , outer_height_of_each_line , width_of_border ) ;
}