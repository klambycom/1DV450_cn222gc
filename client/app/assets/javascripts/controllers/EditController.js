/*global app */

app.controller('EditController', ['$scope', '$routeParams', '$location', 'Resource',
                                  'License', 'ResourceTypes', 'Alert',
    function ($scope, $routeParams, $location, Resource, License, ResourceTypes, Alert) {

        'use strict';

        var find = function (obj, key) {
            return function (x) { return obj[key] === x[key]; };
        };

        $scope.resource = {};

        // Get all data needed
        License.query(function (res) {
            $scope.licenses = res.items;
        }, Alert.error('License'));

        ResourceTypes.query(function (res) {
            $scope.resourceTypes = res.items;
        }, Alert.error('ResourceTypes'));

        if ($routeParams.id) {
            Resource.get({ id: $routeParams.id }, function (res) {
                $scope.resource = res;
                $scope.resource.license = $scope.licenses
                    .filter(find(res.license, 'uuid'))[0];
                $scope.resource.resourceType = $scope.resourceTypes
                    .filter(find(res.resource_type, 'uuid'))[0];
            }, Alert.error('Resource'));
        }

        // Submit
        $scope.submit = function () {
            var d = $scope.resource,
                data = {
                    name: d.name,
                    url: d.url,
                    description: d.description,
                    resource_type_id: d.resourceType.uuid,
                    license_id: d.license.uuid
                };

            if ($routeParams.id) {
                Resource.save(data, function (res) {
                    $location.path('/resources/' + res.uuid);
                }, Alert.error('Resource'));
            } else {
                Resource.update({ id: $routeParams.id }, data, function (res) {
                    $location.path('/resources/' + res.uuid);
                }, Alert.error('Resource'));
            }
        };
    }]);
