$( '#twitters' ).on 'ajax:ajax:complete' , ( e , domain ) ->
  alert( 'Ajax!: ' + status )
  console.log 'Ajax!'
  $( '#twitters' ).removeClass( 'visible' ).addClass( 'hidden' )