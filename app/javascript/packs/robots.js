$("#robot-form").bind('ajax:complete', function(e, data, status, xhr) {
  console.log("HEY", data)
});

$('#robot-form').on('ajax:success', function(e, data, status, xhr){
  console.log("HOW", data)
});

let original_board = $("#roverboard").html();

$("#rockmi").click( () => {

  $("#rcmd").prop('disabled', true);

  let lols = $("#rcmd").val();

  Rails.ajax({
    type:"POST",
    url:"/robots/create",
    dataType: 'json',
    data: "cmd=" + sanitize_input(lols).join("|"),
    
    success: (result) => {
      console.log(result);
      animate_robot(result["steps"], () => {
        $("#rcmd").prop('disabled', false);
        // $("#rcmd").val('');
        $("#rcmd").focus();
      })
    }
  });

  // animate_robot([
  //   {x: 0, y:0, f: 'east'},
  //   {x: 1, y:1, f: 'north'},
  //   {x: 2, y:2, f: 'weast'},
  //   {x: 3, y:3, f: 'south'},
  //   {x: 4, y:4, f: 'north'},
  //   {x: 4, y:4, f: 'west'},
  //   {x: 4, y:4, f: 'south'},
  //   {x: 4, y:4, f: 'east'},
  //   {x: 4, y:4, f: 'north'},
  // ], () => {
  //   $("#rcmd").prop('disabled', false);
  //   // $("#rcmd").val('');
  //   $("#rcmd").focus();
  // });
});


let sanitize_input = (input) => {
  return input.split(/\r?\n/).map(x => x.trim().toUpperCase());
}

/*
  { x, y, f}
*/
let animate_robot = (arr, cb) => {

  console.log("received => ", arr );

  arr.forEach(function (e, i) {
    let idx = "#" + e["x"] + e["y"];

    setTimeout(function() {
      $("#roverboard").html(original_board);

      $(idx).addClass(e["f"]).text('🤖');

      if (i === (arr.length - 1)) {
        cb();
      }
    }, i * 1000);
  })
}
