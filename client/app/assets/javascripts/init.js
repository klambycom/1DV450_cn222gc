/*global angular */

var app = angular.module('TOERH', [
		'ngResource',
		'ngCookies',
		'pascalprecht.translate',
		'angular-md5',
		'angularMoment'
	]);

app.config(function ($translateProvider) {
    'use strict';

    // http://www.ng-newsletter.com/posts/angular-translate.html
    // http://angular-translate.github.io
    $translateProvider.translations('en', {
        'ALERT': {
            'Resource': {
                '401': 'Error loading resources because not authorized!',
                '404': 'Could not find the resource.'
            }
        }
    });

    $translateProvider.preferredLanguage('en');
});

app.run(function ($window) {
	'use strict';

	$window.moment.lang('sv');
});
