function ready() {
  console.log("hihi");
}

$(document).on('turbolinks:load', function(){
  ready();
  console.log("load~");

});