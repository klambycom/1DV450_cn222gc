/*global angular, app */

app.controller('ResourcesController', ['$scope', 'Resource', 'Alert',
    function ($scope, Resource, Alert) {
        'use strict';

        var dot = function (a) { return function (b) { return b[a]; }; },
            flatten = function (a) { return [].concat.apply([], a); },
            scopeResult = function (res) {
                $scope.resources = res.items;
                $scope.categories = res.items.map(dot('resource_type'));
                $scope.tags = flatten(res.items.map(dot('tags')));
            };

        Resource.get(scopeResult, Alert.error('Resource'));

        $scope.$on("search-query", function (e, query) {
            Resource.get({ q: query }, scopeResult, Alert.error('Resource'));
        });
    }]);
