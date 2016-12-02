(function(window){
	'use strict';
	var URLs = {
		app: 'cityscope://?pcapi='+window.location.protocol+'//'+window.location.host,
		itunes : 'https://itunes.apple.com/us/app/bulwell-cat-watch/id1146766708?mt=8',
		play : 'https://play.google.com/store/apps/details?id=uk.ac.edina.cps&hl=en_GB'
	};
	window.onload = function(){
		document.getElementById('itunes').setAttribute('href',URLs.itunes);
		document.getElementById('play').setAttribute('href',URLs.play);
		window.location = URLs.app;	//Redirect to the app by default
		setTimeout(function(){
			var parser = new window.UAParser();
			if(parser!==undefined){
				var os = parser.getOS();
				if(os.name === 'iOS')
					window.location = URLs.itunes;
				else if(os.name === 'Android')
					window.location = URLs.play;
				else
					;
			}
		},0);
	};
})(this.window);