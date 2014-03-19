/*global angular, app, console, window */

app.controller('ResourcesController', function ($scope, Resource, AlertFactory) {
    'use strict';

    var dot = function (a) { return function (b) { return b[a]; }; },
        flatten = function (a) { return [].concat.apply([], a); };

    Resource.get(function (res) {
        $scope.resources = res.items;
        $scope.categories = res.items.map(dot('resource_type'));
        $scope.tags = flatten(res.items.map(dot('tags')));
    }, AlertFactory.error('Resource'));

    $scope.email = 'christian@klamby.com';

	$scope.login = function () {
		window.location.href = "http://lvh.me:3001/auth/toerh_doorkeeper";
	};

    //Resource.query({ id: '94240bb3-b367-4166-bf1b-6cf4dfbb8c66' }, function (res) {
    //  console.log(res);
    //}, AlertFactory.error('Resource'));
});
