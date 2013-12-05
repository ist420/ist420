# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
update = -> $('#clock').text -> moment().format('hh:mm:ss MMM Do \'YY');
$(document).ready -> update();
setInterval(update,800);
