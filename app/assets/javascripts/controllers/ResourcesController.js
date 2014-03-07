/*global angular, app, console */

app.controller('ResourcesController', function ($scope, Resource, AlertFactory) {
	'use strict';

	Resource.get(function (res) {
		$scope.resources = res.items;
	}, AlertFactory.error('Resource'));

	//Resource.query({ id: '94240bb3-b367-4166-bf1b-6cf4dfbb8c66' }, function (res) {
	//	console.log(res);
	//}, AlertFactory.error('Resource'));
});
