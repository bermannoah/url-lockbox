$( document ).ready(function(){
  $("body").on("click", ".mark-as-read", markAsRead)
})

function markAsRead(e) {
  e.preventDefault();
  var url = this.classList[3]
  // if more classes are added to the button TD, increment this number
  var $link = $(this).parents('tr');
  var linkId = parseInt($link[0].id);

  $.ajax({
    type: "PUT",
    url: "/api/v1/links/" + linkId,
    data: { read: true },
  }).then(updateLinkStatus(linkId))
    .then(sendLinkToHotReads(url));
}

function updateLinkStatus(linkId) {
  $(`.link[id=${linkId}]`).find(".read-status").text(linkId.read);
}

function sendLinkToHotReads(urlToSend) {
  $.ajax({
    type: "POST",
    url: "https://boiling-castle-93715.herokuapp.com/api/v1/links",
    data: { urlToSend }
  })
}

