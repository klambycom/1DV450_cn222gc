/*global app, console */

app.controller('EditController', ['$scope', '$routeParams', '$location', 'Resource',
                                  'License', 'ResourceTypes', 'Alert',
    function ($scope, $routeParams, $location, Resource, License, ResourceTypes, Alert) {

        'use strict';

        $scope.newData = {};

        // Get all data needed
        License.query(function (res) {
            $scope.licenses = res.items;
        }, Alert.error('License'));

        ResourceTypes.query(function (res) {
            $scope.resourceTypes = res.items;
        }, Alert.error('ResourceTypes'));

        if ($routeParams.id) {
            console.log($routeParams.id);

            Resource.get({ id: $routeParams.id }, function (res) {
                $scope.resource = res;
            }, Alert.error('Resource'));
        }

        // Submit
        $scope.submit = function () {
            var d = $scope.newData;

            Resource.save({
                name: d.name,
                url: d.url,
                description: d.description,
                resource_type_id: d.resourceType.uuid,
                license_id: d.license.uuid
            }, function (data) {
                $location.path('/resources/' + data.uuid);
            }, Alert.error('Resource'));
        };
    }]);
