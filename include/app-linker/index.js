(function(window){
	'use strict';
	var URLs = {
		app: 'cityscope://?pcapi='+location.href,
		itunes : 'https://itunes.apple.com/us/app/edinburgh-cityScope-fieldtrip/id1185821739?mt=8',
		surveyDesigner: location.href+'designer/?sid=survey_test#/survey-designer',
		surveyPreviewer: location.href+'preview/#!/?sid=survey_test',
		recordsViewer: location.href+'viewer/?sid=survey_test'
	};
	window.onload = function(){
		var htmlCollection = document.getElementsByClassName('app');
		for(var i=0;i<htmlCollection.length;i++)
			htmlCollection[i].setAttribute('href',URLs.app);
		document.getElementById('itunes').setAttribute('href',URLs.itunes);
		document.getElementById('survey-designer').setAttribute('href',URLs.surveyDesigner);
		document.getElementById('survey-previewer').setAttribute('href',URLs.surveyPreviewer);
		document.getElementById('records-viewer').setAttribute('href',URLs.recordsViewer);
	};
})(this.window);