/*global app */

app.factory('Resource', function ($resource) {
	'use strict';

	var applicationId = '98540e836d1cb2ea0c0a6e2258bcbd3efec7fc22ef7c7d8b31745d192706fe3c',
		token = 'Token token=' + applicationId;

	return $resource('http://api.lvh.me:3000/resources/:id', { id: '@id' }, {
		'get':	  { method: 'GET', headers: { 'Authorization': token } },
		'save':	  { method: 'POST' },
		'query':  { method: 'GET', isArray: true, headers: { 'Authorization': token } },
		'remove': { method: 'DELETE' },
		'delete': { method: 'DELETE' }
	});
});
