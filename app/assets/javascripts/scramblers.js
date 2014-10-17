var slot_ids_array = new Array();
//var slot_ids_array_with_flags = new Array();
var availability_array = new Array();

function scramble() {
 
   	$('#cardPile').show();
	$('#cardSlots').show();

  // Reset the game
   correctCards = 0;
   $('#cardPile').html( '' );
   $('#cardSlots').html( '' );
  
   var clicks_count = new Array();
   var click_type = '';
   //note: the array shuffled_rows is randomized, but the array words is also randomized, that's why we need the array rows_saved
   var rows = ["test1", "test2", "test3"];
   var rows_saved = rows.slice(0); 
   var shuffled_rows = rows.sort(function() { return 0.5 - Math.random();});
  
  for( var i=0; i<rows.length; i++ ) {
    var sentence = rows[i];
	var font_size_str = '24 px';
	var background_str = '#99CCFF';
    $('<div>' + sentence + '</div>').data( 'word', sentence).data( 'test', 'testdata').attr( 'id', 'card'+i).css('font-size',font_size_str).appendTo( '#cardPile' ).click('click', function(){
	    var card_offset = $(this).offset();
		//if click count is a odd number, move card to a slot
		//if not (which means card has been clicked previously)
		//then move card back to original position
		var card_id = $(this).attr('id');
		var c_count = clicks_count[card_id];
		////console.log(" click");
		var shift_vertical;
		var shift_horizontal;
		if(c_count%2 == 0) {
				//find next available slot in #cardslots		
		var next_slot_id;
		for(var m=0; m < availability_array.length; m++) {
			if(availability_array[m] == "AVAILABLE") {
				next_slot_id = 'slot_'+m;
				$(this).data('my_slot',m);
				var slot_str = '#'+next_slot_id;
				$(slot_str).data('my_card',$(this).attr('id'));
				break;
			}
		}
        ////console.log(" found next available slot: "+next_slot_id);
		    ////console.log("even");
			click_type = 'even';
			
			////console.log(" before animation:  card top = "+card_offset.top);
			var next_slot_id_str = '#' + next_slot_id;
			$(next_slot_id_str).data('my_card',$(this).attr('id'));
			//attach this card to the slot
			var slot_offset = $(next_slot_id_str).offset();
			var fval=slot_offset.top - card_offset.top;
			var num = Math.round(fval);
			var n = num.toString();
			//alert(n);
		    shift_vertical = n+'px'; // '124'+'px';
			var h_val=slot_offset.left - card_offset.left;
			//alert(h_val);
			var num1 = Math.floor(h_val);
			var n1 = num1.toString();
			shift_horizontal = n1+'px';
			$(this).data('ori_shift_vertical', shift_vertical);
			$(this).data('ori_shift_horizontal', shift_horizontal);
			
		}
		else {
			////console.log("odd =");
			click_type = "odd";
			var new_offset = $(this).offset();
			//////console.log(" before animation:  card top = "+new_offset.top);
			shift_vertical = '+0px'; //$(this).data('ori_shift_vertical');
			shift_horizontal = '+0px'; //$(this).data('ori_shift_horizontal');			
		}
		$(this).animate(
		{
			top:shift_vertical,left:shift_horizontal
		},
		{
		  duration : 500,
		  easing   : 'swing',
		  complete : function(){
			//////console.log(slot_ids_array[0]);
			////console.log(" complete ENTRY : available slots");
			for(var n=0; n< slot_ids_array.length; n++) {
				//////console.log(slot_ids_array[n]);
			}			
			var my_slot_id_str = $(this).data('my_slot');
			var my_slot_id = parseInt(my_slot_id_str);
			////console.log(' even click, my_slot_id = '+my_slot_id);
			
			if(click_type == 'even') {
				availability_array[my_slot_id] = "UNAVAILABLE";
			}
			else if(click_type == 'odd') {
				availability_array[my_slot_id] = "AVAILABLE";
			}
			else {
			    ////console.log(' unknown click type');
			}
			clicks_count[$(this).attr('id')]++;
			for(var n=0; n< slot_ids_array.length; n++) {
				////console.log(slot_ids_array[n]);
			}
            //Are all the slots filled? Go thru availability array and find out
			//then check answers
			var done=true;
			for(var n=0; n< availability_array.length; n++) {
				if(availability_array[n] == "AVAILABLE") {
					done=false;
					break;
				}
			}
			if(done) {
				//check errors
				console.log(" DONE ");
				//go thru all the slots
				//var slots_array = $("[id^=slot_]");
				var error = false;
				////console.log(" slots_array size = "+slots_array.length);
				for(var k=0; k< slot_ids_array.length; k++) {
				   var id_str = '#'+ slot_ids_array[k];
				   console.log(slot_ids_array[k]);
				   var my_word = $(id_str).data('word');
				   var m_card = $(id_str).data('my_card');
				   var dropped_text = $('#'+m_card).data('word');
				   //console.log(" dropped text = "+dropped_text);
				   if(my_word != dropped_text) {
						//console.log(" error..."); 
					   error = true;
					   break;
				   }
				}
				//console.log(" ERROR = "+error);
				if(error == false) {					
					$('#cardPile').fadeOut('slow');
					$('#cardSlots').fadeOut('slow');
					$('#output').fadeIn('slow');
				}
			}
		  }
		});
    });
	
	var m_id = 'card'+i;
	clicks_count[m_id] = 0;    //initialize click count for each card
 } //end for  
  console.log(" HERE");
  var max_card_width=0;
	for ( var i=0; i<rows_saved.length; i++ ) {
		$('<div>' + rows_saved[i]['COL 3'] + '</div>').data( 'word', rows_saved[i]['COL 3'] ).attr( 'id', 'slot_'+i).appendTo( '#cardSlots' );
		slot_ids_array.push('slot_'+i);
		availability_array[i] = "AVAILABLE";
	}

} //end function scrambler()
