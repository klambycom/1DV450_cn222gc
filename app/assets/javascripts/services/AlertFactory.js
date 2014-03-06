/*global app, console */

app.factory('AlertFactory', function ($filter, $translate) {
	'use strict';

	var createError = function (message) {
			console.log('ERROR! ' + message);
		},
		createInfo = function (message) {
			console.log('INFO! ' + message);
		},
		createWarning = function (message) {
			console.log('WARNING! ' + message);
		},
		createSuccess = function (message) {
			console.log('SUCCESS! ' + message);
		};

	return {
		error: function (type) {
			return function (error) {
				$translate('ALERT.' + type + '.' + error.status)
					.then(createError);
			};
		},
		info: function (key) {
			$translate(key)
				.then(createInfo);
		},
		warning: function (key) {
			$translate(key)
				.then(createWarning);
		},
		success: function (key) {
			$translate(key)
				.then(createSuccess);
		}
	};
});
