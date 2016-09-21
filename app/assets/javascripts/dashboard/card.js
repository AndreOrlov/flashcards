var ready = function () {
  $('#image_remote').val('');

  var search_flickr = $( "#search_flickr" ).click(function() {
    //console.log( "Handler for #search_flickr.click() called." );
    var text =$("#search-term").val();
    if(text!='') {
      console.log('Search text is ' + text);
      //console.log('Method is ' + $(this).data('method'));
      //console.log('URL is ' + $(this).data("url"));
      $.ajax({
        type: $(this).data('method'),
        url: $(this).data('url'),
        data: {flickr: {search_tag: text}},
        timeout: 60000, //ms
        beforeSend: beforeSendAJAXFlickr,
        success: function (data) {filling_pics(data.count, data.photos)},
        error: function(jqXHR, textStatus, errorThrown ){
          console.log('Error query to Flickr API. Error is \'' + textStatus + '\'');
          //TODO show on page element error for user
          alert('Error query to Flickr API. Error is \'' + textStatus + '\'');
        },
        complete: completeAJAXFlickr
      });
    }
  });
};
$(document).ready(ready);
$(document).on('page:load', ready);

var gFlickr = false;
var show_flicker = function (event_object) {
  var f = $(event_object).prop('checked');
  $('#flicker').toggle(f);
  if (gFlickr) {
    $('#flickr-cont').toggle(f);
    $('#current_flickr').toggle(f);
  };
  if (f)
    hide_element($('#choice-file'));
  else
    show_element($('#choice-file'));
};

var set_image_remote = function(event_object){
  var link = $(event_object).attr('src');
  $('#image_remote').val(link);
  $('form input[type=file]').val('');

  var obj = $('#current_flickr');
  $('img', obj).attr('src', link);
  if(obj.is(':hidden'))
      obj.show();
};

var hide_element = function(object){
  var clear = $(object).data('id-clearing');
  $(object).hide();
  $('#'+clear).val('');
};

var show_element = function(object){
  $(object).show();
};

var search_flickr = $( "#search_flickr" ).click(function() {
  //console.log( "Handler for #search_flickr.click() called." );
  var text =$("#search-term").val();
  if(text!='') {
    console.log('Search text is ' + text);
    //console.log('Method is ' + $(this).data('method'));
    //console.log('URL is ' + $(this).data("url"));
    $.ajax({
      type: $(this).data('method'),
      url: $(this).data('url'),
      data: {flickr: {search_tag: text}},
      timeout: 60000, //ms
      beforeSend: beforeSendAJAXFlickr,
      success: function (data) {filling_pics(data.count, data.photos)},
      error: function(jqXHR, textStatus, errorThrown ){
        console.log('Error query to Flickr API. Error is \'' + textStatus + '\'');
        //TODO show on page element error for user
        alert('Error query to Flickr API. Error is \'' + textStatus + '\'');
      },
      complete: completeAJAXFlickr
    });
  }
});

var filling_pics = function(cnt, arr){
  if($('a[name=flickr-pic]').length != arr.length){
    console.log('WARNiNG. Count links name=flickr-pics != data.count element recieve from ajax.')
  }
  arr.forEach(function(item, i, arr) {
    console.log(item.url);
  });

  var pics = arr;
  $('a[name=flickr-pic]').each(function(i, item){
    $('img', item).attr('src', pics[i].url);
    $('img', item).attr('alt', pics[i].title);
  });

  $('#flickr-cont').show();
  gFlickr = true;

};

var beforeSendAJAXFlickr = function(){

  console.log('Started AJAX');
  $('#search_flickr').css('pointer-events', 'none');
  $('#btn-save').prop('disabled', true);

  var obj = $('i', $('#search_flickr'));
  obj.removeClass('glyphicon-search');
  obj.addClass('glyphicon-refresh glyphicon-spin');
};

var completeAJAXFlickr = function(){
  console.log('Finished AJAX');
  $('#search_flickr').css('pointer-events', '');
  $('#btn-save').prop('disabled', false);

  var obj = $('i', $('#search_flickr'));
  obj.removeClass('glyphicon-refresh glyphicon-spin');
  obj.addClass('glyphicon-search');
};

