$(function(){
  $(".root")
    .on("click", ".icon, .text", function(e){
      $(this).parent().toggleClass("selected");
    })
    .on("click", ".node > .handle", function(e){
      $(this).parent().next(".branch").collapse("toggle");
    })
    .on("hidden.bs.collapse show.bs.collapse", ".collapse", function(event){
      event.stopPropagation()
      $(this).prev().find(".handle")
        .toggleClass("glyphicon-triangle-bottom")
        .toggleClass("glyphicon-triangle-right");
    })
    .find(".node").each(function(){
      console.log(".node", $(this).text());
    }).filter(function(){
      return $(this).next(".branch").length === 0;
    }).find(".handle")
    .removeClass("glyphicon-triangle-right")
    .addClass("glyphicon-unchecked");
});