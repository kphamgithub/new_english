CKEDITOR.editorConfig = function( config ) {    
	
    config.uiColor = '#AADC6E';
	    // Declare the additional plugin 
		// Declare the additional plugin
	//config.extraAllowedContent = 'img[src,alt,width,height]';
	CKEDITOR.config.allowedContent = true;
	//CKEDITOR.config.extraAllowedContent = 'hr {*}(*)';
	config.extraPlugins = 'timestamp';	
	config.extraPlugins = 'abbr';
	config.protectedSource.push(/<i[^>]*><\/i>/g);
	config.protectedSource.push(/<a[^>]*><\/a>/g);
 };