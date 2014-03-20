/*jslint es5: true */
/*global app, angular */

app.controller('DetailsController', ['$scope', '$routeParams', '$location',
                                     'Resource', 'Alert', 'User',
    function ($scope, $routeParams, $location, Resource, Alert, User) {
        'use strict';

        $scope.createdByMe = false;

        Resource.get({ id: $routeParams.id }, function (res) {
            $scope.resource = res;

            var currentUser = $scope.$parent.user,
                resourceUser = $scope.resource.user;

            if (angular.isDefined(currentUser)) {
                $scope.createdByMe = resourceUser.uuid === currentUser.uuid;
            }
        }, function (error) {
            Alert.error('Resource')(error);
            if (error.status === 404) { $location.path('/'); }
        });

        $scope.remove = function () {
            Resource.delete({ id: $routeParams.id }, function (res) {
                Alert.success('ALERT.Resource.DELETE');
                $location.path('/');
            }, Alert.error('Resource'));
        };
    }]);
