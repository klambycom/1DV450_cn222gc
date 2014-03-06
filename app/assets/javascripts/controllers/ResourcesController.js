/*global angular, app, console */

app.controller('ResourcesController', function ($scope, Resource, AlertFactory) {
	'use strict';

	Resource.get(function (res) {
		$scope.resources = res.items;
	}, AlertFactory.error('Resource'));
});
