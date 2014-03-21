/*global app, angular */

app.controller('AdminController', ['$scope', '$location', 'User', 'Alert',
                                   'ResourceTypes', 'License',
    function ($scope, $location, User, Alert, ResourceTypes, License) {
        'use strict';

        if (!User.me().isAdmin) {
            Alert.info('ALERT.NotAdmin');
            $location.path('/');
        }

        // License
        $scope.license = {};

        $scope.submitLicense = function () {
            License.save($scope.license, function () {
                $scope.license = {};
                Alert.success('ALERT.License.Created');
            }, Alert.error('License'));
        };

        // Resource type
        $scope.resourceType = {};

        $scope.submitResourceType = function () {
            ResourceTypes.save($scope.resourceType, function () {
                $scope.resourceType = {};
                Alert.success('ALERT.ResourceTypes.Created');
            }, Alert.error('ResourceTypes'));
        };
    }]);
