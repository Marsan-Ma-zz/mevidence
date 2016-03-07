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
//= notrequire turbolinks
//= require bootstrap-sprockets
//= require_tree .


$(".select_cat").on('change', function() {
  var val = $(this).val();
  $(this).children("option").each(function(idx){
    if ($(this).val() == val) {
      window.location.href = $(this).attr('href');    
    }
  });
});
