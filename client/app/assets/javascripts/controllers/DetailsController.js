/*global app, angular */

app.controller('DetailsController', ['$scope', '$routeParams', 'Resource',
                                     'Alert', 'User',
    function ($scope, $routeParams, Resource, Alert, User) {
        'use strict';

        $scope.createdByMe = false;

        Resource.get({ id: $routeParams.id }, function (res) {
            $scope.resource = res;

            var currentUser = $scope.$parent.user,
                resourceUser = $scope.resource.user;

            if (angular.isDefined(currentUser)) {
                $scope.createdByMe = resourceUser.uuid === currentUser.uuid;
            }
        }, Alert.error('Resource'));
    }]);
