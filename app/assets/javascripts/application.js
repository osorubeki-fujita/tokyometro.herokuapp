// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require underscore/underscore-min
//= require_tree .

//-------- 使用していない Version
// require jquery
// require jquery_ujs
// require turbolinks
// require bootstrap.min
// require underscore
// require gmaps/google
// require_tree .

const goldenRatio = 1.618 ;

$( document ).on( 'ready page:load' , function() { // Turbolinks 対策
  // $( function() {
  // $( document ).live( 'pageshow', function() {
  initializer = new Initializer() ;
  initializer.process() ;
});

observer_of_station_facility_platform_info_tab = new ObserverOfStationFacilityPlatformInfoTab() ;
window.setInterval( 'observer_of_station_facility_platform_info_tab.listen()' , observer_of_station_facility_platform_info_tab.duration() ) ;