/*global angular, app */

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
});
