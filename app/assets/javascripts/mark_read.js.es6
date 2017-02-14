$( document ).ready(function(){
  $("body").on("click", ".mark-as-read", markAsRead)
})

function markAsRead(e) {
  e.preventDefault();
  var $link = $(this).parents('tr');
  var linkId = parseInt($link[0].id);

  $.ajax({
    type: "PUT",
    url: "/api/v1/links/" + linkId,
    data: { read: true },
  }).then(updateLinkStatus(linkId));
}

function updateLinkStatus(linkId) {
  $(`.link[id=${linkId}]`).find(".read-status").text(linkId.read);
}