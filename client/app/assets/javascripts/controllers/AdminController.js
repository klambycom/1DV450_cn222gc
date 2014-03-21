/*global app, angular */

app.controller('AdminController', ['$scope', '$location', 'Alert',
                                   'ResourceTypes', 'License',
    function ($scope, $location, Alert, ResourceTypes, License) {
        'use strict';

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
