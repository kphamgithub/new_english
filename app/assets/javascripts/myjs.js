
var yourAudio = document.getElementById('myAudio'),
    ctrl = document.getElementById('audioControl');

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
	$('#quiz_button').toggle()
	$('#quiz_button').css("color","red")
	$('#quiz_button').css("background","pink")
}

function video_started() {
	alert("video started");
}


