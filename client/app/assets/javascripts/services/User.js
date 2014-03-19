/*global app */

app.factory('User', function ($cookies, $resource) {
	'use strict';

	var applicationId = '98540e836d1cb2ea0c0a6e2258bcbd3efec7fc22ef7c7d8b31745d192706fe3c',
		token = 'Token token=' + applicationId,
	    access_token = 'Bearer ' + $cookies.access_token;

	return $resource('http://api.lvh.me:3000/users/:id', { id: '@id' }, {
		'me':  { method: 'GET', headers: { 'Authorization': access_token } },
		'get': { method: 'GET', headers: { 'Authorization': token } }
	});
});
