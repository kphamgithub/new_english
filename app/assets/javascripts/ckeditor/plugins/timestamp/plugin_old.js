// Register the plugin within the editor.
CKEDITOR.plugins.add( 'timestamp', {
	// Register the icons. They must match command names.
	icons: 'timestamp',
	// The plugin initialization logic goes inside this method.
	init: function( editor ) {
		// Define the editor command that inserts a timestamp.
		editor.addCommand( 'insertTimestamp', {
			// Define the function that will be fired when the command is executed.
			exec: function( editor ) {
				//var now = new Date();
			    //var value = '<img src="/images/timestamp.jpg">';
				var value = '<audio controls="controls"><source src="/audios/voca/attack.mp3" type="audio/mpeg"> Your browser does not support the audio element.</audio>';
				editor.insertHtml(value);
			}
		});

		//<img src="smiley.gif" alt="Smiley face" width="42" height="42">
		
		// Create the toolbar button that executes the above command.
		editor.ui.addButton( 'Timestamp', {
			label: 'Insert Timestamp',
			command: 'insertTimestamp',
			toolbar: 'insert'
		});
	}
});