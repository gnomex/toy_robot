$("#robot-form").bind('ajax:complete', function(e, data, status, xhr) {
  console.log("HEY", data)
});

$('#robot-form').on('ajax:success', function(e, data, status, xhr){
  console.log("HOW", data)
});

let original_board = $("#roverboard").html();

$("#rockmi").click(function () {
  Rails.ajax({
    type:"POST",
    url:"/robots/create",
    data: "cmd[commands]='PLACE 1,2,EAST'",
    success: function(result){
      console.log(result);
    }
  });

  animate_robot([
    {x: 0, y:0, f: 'east'},
    {x: 1, y:1, f: 'north'},
    {x: 2, y:2, f: 'weast'},
    {x: 3, y:3, f: 'south'},
    {x: 4, y:4, f: 'north'},
    {x: 4, y:4, f: 'west'},
    {x: 4, y:4, f: 'south'},
    {x: 4, y:4, f: 'east'},
    {x: 4, y:4, f: 'north'},
  ]);
});


/*
  { x, y, f}
*/
let animate_robot = (arr) => {
  arr.forEach(function (e, i) {
    let idx = "#" + e["x"] + e["y"];

    setTimeout(function() {
      $("#roverboard").html(original_board);

      $(idx).addClass(e["f"]).text('🤖');
    }, i * 1000);
  })
}
