const original_board = $("#roverboard").html();

$("#rockmi").click( () => {

  let commands = $("#rcmd").val();

  if (!commands) { 
    $("#rcmd").focus();
    return;
  }

  disble_form();

  Rails.ajax({
    type:"POST",
    url:"/robots/create",
    dataType: 'json',
    data: "cmd=" + sanitize_input(commands).join("|"),
    
    success: (result) => { animate_robot(result["steps"], enable_form) },
    error: (result) => { enable_form() }
  });
});

let disble_form = () => {
  $("#rcmd").prop('disabled', true);
  $("#rockmi").attr("disabled", "disabled");
  $("#rockmi").addClass("disabled");
}

let enable_form = () => {
  $("#rockmi").removeAttr("disabled");
  $("#rockmi").removeClass("disabled");
  
  $("#rcmd").prop('disabled', false);
  $("#rcmd").focus();
}

let sanitize_input = (input) => {
  // map removing extra white spaces, transforming to upcase, and filter non emtpy
  return input.split(/\r?\n/).map(x => x.trim().toUpperCase()).filter( y => y !== "");
}

/*
  { x, y, f}
*/
let animate_robot = (arr, cb) => {
  arr.forEach(function (e, i) {
    let idx = "#" + e["x"] + e["y"];

    setTimeout(function() {
      $("#roverboard").html(original_board);

      $(idx).addClass(e["f"]).text('🤖');

      if (i === (arr.length - 1)) { cb() }

    }, i * 1000);
  })
}
