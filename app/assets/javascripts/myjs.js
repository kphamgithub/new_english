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

//when the Add Field button is clicked

function addBox(item_name) {
   var my_form = $("body").find("form").first();
   var form_id = my_form.attr('id'); // "new_multichoicequestion"
   var form_id_parts = form_id.split("_");
   var form_name = form_id_parts[1]; // "multichoicequestion"
									  
   var last_fields_element = my_form.find(".fields").last();
   
   var text_area_element = last_fields_element.children().last();
   //var last_input_element = last_fields_element.child
   var textarea_id_parts = text_area_element.attr('id').split("_");
   var new_id_index = (parseInt(textarea_id_parts[4])+1).toString();
   var nested_attributes_name = textarea_id_parts[1] + "_" + textarea_id_parts[2]; 
   
   //alert(nested_attributes_name);
   
   var new_input_id = form_name + "_" + nested_attributes_name + "_" + "attributes" + "_" + new_id_index+ "_" + item_name;
   
   var new_input_name = form_name + "[" + nested_attributes_name + "_" + "attributes" + "]" + "[" + new_id_index + "]" + "[" + item_name + "]" ;
             
   //append a <p> with a <textarea> then set the id and name of the <textarea>
   $('<p class="fields"><textarea></textarea></p>').insertAfter(last_fields_element).find("textarea").attr({ id: new_input_id, name: new_input_name });
}

function removeBox() {
   var my_form = $("body").find("form").first();
   //alert(my_form.attr('id'))
   var last_fields_element = my_form.find(".fields").last();
   //var last_fields_element = $(form_id).find(".fields").last();
   last_fields_element.remove();
}

function addBoxes(item_name, item_name1) {
   var my_form = $("body").find("form").first();
   var form_id = my_form.attr('id'); // "new_multichoicequestion"
   var form_id_parts = form_id.split("_");
   var form_name = form_id_parts[1]; // "multichoicequestion"
									  
   var last_fields_element = my_form.find(".fields").last();
   
   var text_area_element = last_fields_element.children().last();
   //var last_input_element = last_fields_element.child
   var textarea_id_parts = text_area_element.attr('id').split("_");
   var new_id_index = (parseInt(textarea_id_parts[4])+1).toString();
   var nested_attributes_name = textarea_id_parts[1] + "_" + textarea_id_parts[2]; 
   
   //alert(nested_attributes_name);
   
   var new_textarea_id = form_name + "_" + nested_attributes_name + "_" + "attributes" + "_" + new_id_index+ "_" + item_name;
   
   var new_textarea_name = form_name + "[" + nested_attributes_name + "_" + "attributes" + "]" + "[" + new_id_index + "]" + "[" + item_name + "]" ;
   
   //add a new <p> element with classname = "fields" and a textarea, set the textarea id and name
   
   $('<p class="fields"><textarea></textarea></p>').insertAfter(last_fields_element).find("textarea").attr({ id: new_textarea_id, name: new_textarea_name });

   //***add second textarea on the same row for match question**
   last_fields_element = my_form.find(".fields").last();
   
   var new_textarea_id1 = form_name + "_" + nested_attributes_name + "_" + "attributes" + "_" + new_id_index+ "_" + item_name1;
   
   var new_textarea_name1 = form_name + "[" + nested_attributes_name + "_" + "attributes" + "]" + "[" + new_id_index + "]" + "[" + item_name1 + "]" ;

   //add a new <textare> element and set id and name
   $('<textarea ></textarea>').insertAfter(last_fields_element.children().last()).attr({ id: new_textarea_id1, name: new_textarea_name1 });
  
}

function add3Boxes(item_name1, item_name2, item_name3) {
   var my_form = $("body").find("form").first();
   var form_id = my_form.attr('id'); // "new_multichoicequestion"
   var form_id_parts = form_id.split("_");
   var form_name = form_id_parts[1]; // "multichoicequestion"
									  
   var last_fields_element = my_form.find(".fields").last();
   
   var text_area_element = last_fields_element.children().last();
   //var last_input_element = last_fields_element.child
   var textarea_id_parts = text_area_element.attr('id').split("_");
   var new_id_index = (parseInt(textarea_id_parts[4])+1).toString();
   var nested_attributes_name = textarea_id_parts[1] + "_" + textarea_id_parts[2]; 
   
   //alert(nested_attributes_name);
   
   var new_textarea_id1 = form_name + "_" + nested_attributes_name + "_" + "attributes" + "_" + new_id_index+ "_" + item_name1;
   
   var new_textarea_name1 = form_name + "[" + nested_attributes_name + "_" + "attributes" + "]" + "[" + new_id_index + "]" + "[" + item_name1 + "]" ;
   
   //add a new <p> element with classname = "fields" and a textarea, set the textarea id and name
   
   $('<p class="fields"><textarea></textarea></p>').insertAfter(last_fields_element).find("textarea").attr({ id: new_textarea_id1, name: new_textarea_name1 });

   //***add second textarea on the same row*
   last_fields_element = my_form.find(".fields").last();
   
   var new_textarea_id2 = form_name + "_" + nested_attributes_name + "_" + "attributes" + "_" + new_id_index+ "_" + item_name2;
   
   var new_textarea_name2 = form_name + "[" + nested_attributes_name + "_" + "attributes" + "]" + "[" + new_id_index + "]" + "[" + item_name2 + "]" ;

   //add a new <textare> element and set id and name
   $('<textarea ></textarea>').insertAfter(last_fields_element.children().last()).attr({ id: new_textarea_id2, name: new_textarea_name2 });
  
   //***add third textarea on the same row*
   last_fields_element = my_form.find(".fields").last();
   
   var new_textarea_id3 = form_name + "_" + nested_attributes_name + "_" + "attributes" + "_" + new_id_index+ "_" + item_name3;
   
   var new_textarea_name3 = form_name + "[" + nested_attributes_name + "_" + "attributes" + "]" + "[" + new_id_index + "]" + "[" + item_name3 + "]" ;

   //add a new <textare> element and set id and name
   $('<textarea ></textarea>').insertAfter(last_fields_element.children().last()).attr({ id: new_textarea_id3, name: new_textarea_name3 });
  }
