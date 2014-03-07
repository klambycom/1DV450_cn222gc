/*global describe, it, expect, inject, beforeEach, spyOn */

describe('ResourcesController', function () {
	'use strict';

	var AlertFactory, $scope, $rootScope, $httpBackend, createController;

	beforeEach(inject(function ($injector) {
		AlertFactory = $injector.get('AlertFactory');
		$httpBackend = $injector.get('$httpBackend');
		$rootScope = $injector.get('$rootScope');
		$scope = $rootScope.$new();

		var $controller = $injector.get('$controller');

		createController = function () {
			return $controller('ResourcesController', {
				'$scope': $scope
			});
		};
	}));

	describe('load resources', function () {
		beforeEach(function () {
			spyOn(AlertFactory, 'error');
		});

		describe('success', function () {
			it('should not show error message');
			it('should change $scope.resources');
		});

		describe('fail', function () {
			it('should show error message');
			it('should not change $scope.resources');
		});
	});
});
