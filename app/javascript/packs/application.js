import "bootstrap";

console.log("Hello World from /pack/application.js");
// $(document).on('turbolinks:load',function() {

// REMOVE FIELD____________________________________________
  $('form').on('click', '.remove_record', function(event) {
    $(this).prev('input[type=hidden]').val('1'); // val => TRUE
    $(this).closest('div').hide();
    return event.preventDefault();
  });

// ADD FIELD____________________________________________
  $('form').on('click', '.add_fields', function(event) {
    const time = new Date().getTime();
    const regexp = new RegExp($(this).data('id'), 'g')
    $('.fields').append($(this).data('fields').replace(regexp, time))
    return event.preventDefault();
  });

// }); // end of Turbolinks:LOAD

// No DATA are passed on Ajax Request ( handled by Rounds#TOGGLE )
// $('input[name*="checkbox_round"]').on('ajax:success', function(data,status,xhr) {
//   console.log("data",data);
//   console.log("status",status);
//   console.log("xhr",xhr);
// })

var pusher = new Pusher('222d943fdebfb1ef78b4', {
  cluster: 'eu',
  forceTLS: true
});

var channel = pusher.subscribe('round');
channel.bind('update', function(data) {
  const url =  window.location.href

  if (url.match(/games\/\d+/)) { // only if in Game#SHOW
    // no data needed, refreshing both sides ( admin/guest )
    window.location.reload()
  }

});
