/*global angular, app, console */

app.controller('ResourcesController', function ($scope, Resource) {
	'use strict';

	Resource.get(function (res) {
		$scope.resources = res.items;
	}, function (error) {
		console.log(error);
	});
});
