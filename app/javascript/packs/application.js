import "bootstrap";

console.log("Hello World");
// $(document).on('turbolinks:load',function() {
  console.log("Turbolinks!");

// REMOVE FIELD
  $('form').on('click', '.remove_record', function(event) {
    $(this).prev('input[type=hidden]').val('1'); // val=>TRUE
    $(this).closest('div').hide();
    return event.preventDefault();
  });

// ADD FIELD
  $('form').on('click', '.add_fields', function(event) {
    const time = new Date().getTime();
    const regexp = new RegExp($(this).data('id'), 'g')
    $('.fields').append($(this).data('fields').replace(regexp, time))
    return event.preventDefault();
  });

// }); // end of Turbolinks:LOAD
