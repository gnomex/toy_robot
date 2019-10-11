Rails.ajax({
  url: "/robots/create",
  type: "POST",
  data: "PLACE 1,2,SOUTH|REPORT|MOVE|PLACE 1,2,SOUTH|MOVE|REPORT|RIGHT|LEFT|RIGHT|LEFT|MOVE|MOVE|REPORT",
  success: function(data) {
    console.log(data);
  }
});

