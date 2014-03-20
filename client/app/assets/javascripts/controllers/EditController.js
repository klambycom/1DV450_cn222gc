/*global app */

app.controller('EditController', ['$scope', '$routeParams', '$location', 'Resource',
                                  'License', 'ResourceTypes', 'Alert', 'User',
    function ($scope, $routeParams, $location, Resource, License, ResourceTypes,
              Alert, User) {

        'use strict';

        if (!User.authenticated) {
            Alert.info("ALERT.Resource." + ($routeParams.id ? 'Edit' : 'Create') + '.NotLoggedIn');
            $location.path('/');
        }

        var find = function (obj, k) {
                return function (x) { return obj[k] === x[k]; };
            },
            dot = function (k) { return function (x) { return x[k]; }; },
            licensePromise,
            resourceTypePromise;

        $scope.resource = {};

        // Get all data needed
        licensePromise = License.query(function (res) {
            $scope.licenses = res.items;
        }, Alert.error('License')).$promise;

        resourceTypePromise = ResourceTypes.query(function (res) {
            $scope.resourceTypes = res.items;
        }, Alert.error('ResourceTypes')).$promise;

        // Get resource if edit
        if ($routeParams.id) {
            Resource.get({ id: $routeParams.id }, function (res) {
                $scope.resource = res;
                $scope.resource.tags = res.tags.map(dot('tag')).join(', ');

                // Find current license
                licensePromise.then(function () {
                    $scope.resource.license = $scope.licenses
                        .filter(find(res.license, 'uuid'))[0];
                });

                // Find current resource type
                resourceTypePromise.then(function () {
                    $scope.resource.resourceType = $scope.resourceTypes
                        .filter(find(res.resource_type, 'uuid'))[0];
                });
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
                    license_id: d.license.uuid,
                    tags: JSON.stringify(d.tags
                           .split(',')
                           .map(function (x) { return x.trim(); }))
                };

            if ($routeParams.id) {
                Resource.update({ id: $routeParams.id }, data, function (res) {
                    Alert.success('ALERT.Resource.PUT');
                    $location.path('/resources/' + res.uuid);
                }, Alert.error('Resource'));
            } else {
                Resource.save(data, function (res) {
                    Alert.success('ALERT.Resource.POST');
                    $location.path('/resources/' + res.uuid);
                }, Alert.error('Resource'));
            }
        };
    }]);
