/*global app */

app.controller('DetailsController', ['$scope', '$routeParams', 'Resource', 'AlertFactory',
    function ($scope, $routeParams, Resource, AlertFactory) {
        'use strict';

        Resource.get({ id: $routeParams.id }, function (res) {
            $scope.resource = res;
        }, AlertFactory.error('Resource'));
    }]);
