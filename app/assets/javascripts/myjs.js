
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

	   function playPause1() {
       var song = document.getElementById('iconaudio1');
	   //alert("jere");
       if (song.paused)
           song.play();
       else
           song.pause();
       }

	   function playPause2() {
       var song = document.getElementById('iconaudio2');
	   //alert("jere");
       if (song.paused)
           song.play();
       else
           song.pause();
       }

	   function playPause3() {
       var song = document.getElementById('iconaudio3');
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


