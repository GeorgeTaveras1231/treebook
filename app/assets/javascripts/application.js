// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


new Hoverable(".counter", {
  //css class for hover box
  class: "hoverable", 
  //ask this path for corresponding partial
  //which is being handled by HoverableController
  //the current partial is at likes/_hoverable.html.erb
  partial_path: "/hoverable/like_counter", 
  //data function specifies how to handle the data provided
  //on the data-hoverable attribute before it is sent to the
  //partial path as a parameter
  data: function( hoverableId, currentTarget ){
    return {comments_id: hoverableId}
  },
});
