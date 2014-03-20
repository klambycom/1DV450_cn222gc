/*global app */

app.controller('DetailsController', ['$scope', '$routeParams', 'Resource', 'Alert',
    function ($scope, $routeParams, Resource, Alert) {
        'use strict';

        Resource.get({ id: $routeParams.id }, function (res) {
            $scope.resource = res;
        }, Alert.error('Resource'));
    }]);
