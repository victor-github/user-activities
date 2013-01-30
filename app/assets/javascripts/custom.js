$(function() {
  $('#post_update_button').on('click', function() {
    $.ajax({
      url: '/activities.json',
      data: { activity: { status: $("#status_input").val() } },
      type: "POST",
      async: false
    }).done(function(json) {
      if (json.errors == undefined)
        window.location.href = "http://" + window.location.host + "/activities"
    })
  });

  $('.follow_user_button').on('click', function(ev) {
    $.ajax({
      url: '/users/follow.json',
      data: { user_id: $(this).attr('id').split("_")[2] },
      type: "POST",
      async: false
    }).done(function(json) {
      if (json.errors == undefined)
        window.location.href = "http://" + window.location.host + "/users"
    })
  });

  $('.unfollow_user_button').on('click', function(ev) {
    $.ajax({
      url: '/users/unfollow.json',
      data: { user_id: $(this).attr('id').split("_")[2] },
      type: "POST",
      async: false
    }).done(function(json) {
      if (json.errors == undefined)
        window.location.href = "http://" + window.location.host + "/users"
    })
  })

})
