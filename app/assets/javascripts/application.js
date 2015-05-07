// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require autocomplete-rails
//= require_tree .
$(document).ready(function(){

    $('#characterLeftTitle').text('0');
    $('.title_field').keyup(function () {

        var len = $(this).val().length;
        if (len < 25)
        {
         $('#characterLeftTitle').css('color','red');
       }
       else
       {
        $('#characterLeftTitle').css('color','green');
      }
            $('#characterLeftTitle').text(len);
    });


    $('#characterLeftContent').text('0');
    $('.content_field').keyup(function () {

        
        var len = $(this).val().length;
        if (len < 100)
        {
         $('#characterLeftContent').css('color','red');
       }
       else
       {
        $('#characterLeftContent').css('color','green');
      }
            $('#characterLeftContent').text(len);
    });

   $('.post_vote_up').on("click", function(e) {
      e.preventDefault();
      if((!$(this).hasClass("in-active")) && ($(this).next().hasClass('in-active'))){
        $(this).toggleClass("in-active");
      }
      else if(($(this).hasClass('in-active')) && (!$(this).next().hasClass('in-active'))){
    
        $(this).toggleClass("in-active");
        $(this).next().toggleClass("in-active");

      }
      else
      {

        $(this).toggleClass('in-active');
      }
      var id = $(this).parent().parent().attr('id');
      console.log("ID IS :"+id);
      var type = 'voteup';
      var values = {

      	'post_id': id,
            'type': type
      }
      var ajaxRequest = $.ajax({
          url: '/post_votes',
          type: 'POST', // GET, PUT, DELETE
          data: values
        });

   });
   $('.post_vote_down').on("click", function(e) {
      e.preventDefault();
     if((!$(this).hasClass("in-active")) && ($(this).prev().hasClass('in-active'))){
        $(this).toggleClass("in-active");
      }
      else if(($(this).hasClass('in-active')) && (!$(this).prev().hasClass('in-active'))){
        $(this).toggleClass("in-active");
        $(this).prev().toggleClass("in-active");

      }
      else
      {

        $(this).toggleClass('in-active');
      }
      var id = $(this).parent().parent().attr('id');
      console.log("ID IS :"+id);
      var type = 'votedown';
      var values = {

        'post_id': id,
            'type': type
      }
      var ajaxRequest = $.ajax({
          url: '/post_votes',
          type: 'POST', // GET, PUT, DELETE
          data: values
        });

   });
   $('.comment_vote_up').on("click", function(e) {
      e.preventDefault();
      if((!$(this).hasClass("in-active")) && ($(this).next().hasClass('in-active'))){
        $(this).toggleClass("in-active");
      }
      else if(($(this).hasClass('in-active')) && (!$(this).next().hasClass('in-active'))){
        $(this).toggleClass("in-active");
        $(this).next().toggleClass("in-active");

      }
      else
      {

        $(this).toggleClass('in-active');
      }
      var id = $(this).parent().parent().attr('id');
      console.log("ID IS :"+id);
      var type = 'voteup';
      var values = {

        'comment_id': id,
            'type': type
      }
      var ajaxRequest = $.ajax({
          url: '/comment_votes',
          type: 'POST', // GET, PUT, DELETE
          data: values
        });

   });
   $('.comment_vote_down').on("click", function(e) {
      e.preventDefault();
      if((!$(this).hasClass("in-active")) && ($(this).prev().hasClass('in-active'))){
        $(this).toggleClass("in-active");
      }
      else if(($(this).hasClass('in-active')) && (!$(this).prev().hasClass('in-active'))){
        $(this).toggleClass("in-active");
        $(this).prev().toggleClass("in-active");

      }
      else
      {

        $(this).toggleClass('in-active');
      }
      var id = $(this).parent().parent().attr('id');
      console.log("ID IS :"+id);
      var type = 'votedown';
      var values = {

        'comment_id': id,
            'type': type
      }
      var ajaxRequest = $.ajax({
          url: '/comment_votes',
          type: 'POST', // GET, PUT, DELETE
          data: values
        });

   });
   $('.subscribed').on("click", function(e) {

      e.preventDefault();
      $(this).toggleClass('in-active');
      var sub_val = $('.subscribed').html();

      if(sub_val.trim() === 'Subscribe')
      {
        sub_val = 'Unsubscribe';
        $(this).html('Unsubscribe');
      }
      else
      {
        sub_val = 'Subscribe';
        $(this).html('Subscribe');
      }

      var id = $(this).parent().attr('id');
      console.log("ID IS :"+id);
      var values = {
        'subreddit_id': id,
        'user_id': current_user_id,
        'sub_val': sub_val,
      }
      var ajaxRequest = $.ajax({
          url: '/subscribers',
          type: 'POST', // GET, PUT, DELETE
          data: values
        });

   });
   $('.new-subreddit').on("click", function(e) {
            e.preventDefault();
            var form_data = $('.subreddit_title_field').val();
            var values = {
                subreddit_title: form_data,
            }
            var ajaxRequest = $.ajax({
                url: '/subreddits',
                type: 'POST', // GET, PUT, DELETE
                data: values
            });
   });
   //save form data to localStorage to prevent data loss on form
   $('.new-post').on("click", function(e) {
      var yourObject = $('form').serializeArray();
      localStorage['form_data'] = JSON.stringify(yourObject);     
    });
    var pathname = window.location.pathname; // Returns path only
    if(pathname === '/'){
      localStorage.clear();
    }
    if(localStorage['form_data'] !== undefined)
    {
       $('.title_field').val(JSON.parse(localStorage.getItem('form_data'))[2].value);
       $('.content_field').val(JSON.parse(localStorage.getItem('form_data'))[3].value);
       $('.subreddit_field').val(JSON.parse(localStorage.getItem('form_data'))[4].value);
    }
});