$(function() {
  $('#post_update_button').on('click', function() {
    $.ajax({
      url: '/activities.json',
      data: { activity: { status: $("#status_area").val() } },
      type: "POST",
      async: false
    }).done(function(json) {
      if (json.errors == undefined)
        window.location.href = "http://" + window.location.host + "/activities";
      else
        alert(json.errors)
    })
  })
})
