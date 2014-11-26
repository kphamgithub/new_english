var yourAudio = document.getElementById('myAudio'),
    ctrl = document.getElementById('audioControl');

var new_audio = new Audio('voca/athlete.mp3');

if(!!document.createElement('audio').canPlayType) {

  var player = '<p class="player"> ... </p>\
    <audio>\
      <source src="/path/to/episode1.ogg" type="audio/ogg"></source>\
      <source src="/path/to/episode1.mp3" type="audio/mpeg"></source>\
      <source src="/path/to/episode1.wav" type="audio/x-wav"></source>\
    </audio>';

  $(player).insertAfter("#listen .photo");

}

function playPause() {
       var song = document.getElementById('iconaudio');
	   //alert("jere");
       if (song.paused)
           song.play();
       else
           song.pause();
       }

	   function playMP3(audio_element_id) {
       var song = document.getElementById(audio_element_id);
	   //alert("jere");
       if (song.paused)
           song.play();
       else
           song.pause();
       }

	   
function play_audio() {
	new_audio.play(); 
}

ctrl.onclick = function () {

    // Update the Button
    var pause = ctrl.innerHTML === 'pause!';
    ctrl.innerHTML = pause ? 'play!' : 'pause!';

    // Update the Audio
    var method = pause ? 'pause' : 'play';
    yourAudio[method]();

    // Prevent Default Action
    return false;
};

function video_ended() {
	//alert("myvideo ended");
	play_audio();
	$('#quiz_button').toggle()
	$('#quiz_button').css("color","red")
	$('#quiz_button').css("background","pink")
}

function video_started() {
	alert("video started");
}

$(function() {
    $( "#accordion" ).accordion();
});

$(function() {
    $( "#draggable" ).draggable();
});

$(function() {
  $("#datepicker").datepicker();
});

function remove_field() {
  alert("in here");
}

//when the Add Field button is clicked

function addBox() {
      //var count = //$('#new_multichoicequestion').find(".fields").length;
   //alert(count);
   var last_fields = $('#new_multichoicequestion').find(".fields").last();
   var last_input_element = last_fields.children().last();
   var id_parts = last_input_element.attr('id').split("_");
   var new_id_index = (parseInt(id_parts[4])+1).toString()
   
   var new_label_name = "multichoicequestion_question_multichoices_attributes" + "_" + new_id_index+ "_" + "name";
   
   var new_input_id = "multichoicequestion_question_multichoices_attributes" + "_" + new_id_index+ "_" + "content";
   var new_input_name = "multichoicequestion[question_multichoices_attributes]" + "[" + new_id_index + "]" + "[content]";
   
   $('<p class="fields"><label>question</label><br><textarea></textarea></p>').insertAfter(last_fields);

   var new_last_input_element = $('#new_multichoicequestion').find(".fields").last().children().last();   
   
   new_last_input_element.attr("id",new_input_id);
   new_last_input_element.attr("name",new_input_name);   

   var new_last_label_element = $('#new_multichoicequestion').find(".fields").last().children().first();   
   
   new_last_label_element.attr("for",new_label_name);
}

function removeBox() {
   var last_fields = $('#new_multichoicequestion').find(".fields").last();
   last_fields.remove();
}
