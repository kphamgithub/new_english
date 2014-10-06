/**
 * The abbr plugin dialog window definition.
 *
 * Created out of the CKEditor Plugin SDK:
 * http://docs.ckeditor.com/#!/guide/plugin_sdk_sample_1
 */

// Our dialog definition.
CKEDITOR.dialog.add( 'abbrDialog', function( editor ) {
	return {

		// Basic properties of the dialog window: title, minimum size.
		title: 'Abbreviation Properties',
		minWidth: 400,
		minHeight: 200,

		// Dialog window content definition.
		contents: [
			{
				// Definition of the Basic Settings dialog tab (page).
				id: 'tab-basic',
				label: 'Basic Settings',

				// The tab content.
				elements: [
					{
						// Text input field for the abbreviation text.
						type: 'text',
						id: 'abbr',
						label: 'Abbreviation',

						// Validation checking whether the field is not empty.
						validate: CKEDITOR.dialog.validate.notEmpty( "Abbreviation field cannot be empty." )
					},
					{
						// Text input field for the abbreviation title (explanation).
						type: 'text',
						id: 'title',
						label: 'Explanation',
						validate: CKEDITOR.dialog.validate.notEmpty( "Explanation field cannot be empty." )
					}
				]
			},

			// Definition of the Advanced Settings dialog tab (page).
			{
				id: 'tab-adv',
				label: 'Advanced Settings',
				elements: [
					{
						// Another text field for the abbr element id.
						type: 'text',
						id: 'id',
						label: 'Id'
					}
				]
			}
		],

		// This method is invoked once a user clicks the OK button, confirming the dialog.
		onOk: function() {

			// The context of this function is the dialog object itself.
			// http://docs.ckeditor.com/#!/api/CKEDITOR.dialog
			var dialog = this;

			// Create a new <abbr> element.
			var abbr = editor.document.createElement( 'abbr' );

			// Set element attribute and text by getting the defined field values.
			abbr.setAttribute( 'title', dialog.getValueOf( 'tab-basic', 'title' ) );
			abbr.setText( dialog.getValueOf( 'tab-basic', 'abbr' ) );

			// Now get yet another field value from the Advanced Settings tab.
			var id = dialog.getValueOf( 'tab-adv', 'id' );
			if ( id )
				abbr.setAttribute( 'id', id );

			// Finally, insert the element into the editor at the caret position.

			var mysrc = dialog.getValueOf( 'tab-basic', 'abbr' )			
			//<audio class="audio_volume_only" id="iconaudio1" src="/audios/voca/baseball.mp3"></audio>
			
			var value0 = '<audio class="audio_volume_only" id = \"'+ id + '\"><source '+ 'src='+ '\"' + mysrc + '"'+ ' type= "audio/mpeg"> Your browser does not support the audio element.</audio>';
			
			//<a href="javascript:playMP3('iconaudio1');">
			//<i id="playbutton" class="fa fa-play-circle-o fa-2x"></i>
			//</a>
			
			var value1 = '<a href='+'\"'+'javascript:playMP3(\''+ id +'\');\">'
			
			var value2 = '<i id=\"playbutton\" class=\"fa fa-play-circle-o fa-2x\"></i></a>'
			//<i id="playbutton" class="fa fa-play-circle-o fa-2x"></i>
			//</a>
			var value = value0 + value1 + value2
			//var value = '<audio controls="controls"><source '+ 'src='+ '\"' + mysrc + '"'+ ' type= "audio/mpeg"> Your browser does not support the audio element.</audio>';
			alert(value)
			editor.insertHtml(value);
			//
		}
	};
});
