/*global angular, initData */

angular.module('TOERH').controller('ResourcesController', function ($scope) {
	'use strict';

	$scope.resources = initData.items;
});
