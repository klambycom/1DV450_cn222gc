/*global angular, app */

app.controller('ResourcesController', ['$scope', '$routeParams', '$location', 'Resource',
                                       'ResourceTypes', 'License', 'Alert', 'Tag',
    function ($scope, $routeParams, $location, Resource, ResourceTypes, License, Alert, Tag) {
        'use strict';

        var dot = function (a) { return function (b) { return b[a]; }; },
            flatten = function (a) { return [].concat.apply([], a); },
            scopeResult = function (res) {
                $scope.resources = res.items;
                $scope.meta = res.meta;
                $scope.tags = flatten(res.items.map(dot('tags')));

                $scope.pages = Math.ceil($scope.meta.length / $scope.meta.limit);
            },
            q = "",
            category = { name: "Alla", uuid: "alla" },
            license = { name: "Alla", uuid: "alla" },
            getResource = function (offset) {
                var data = { query: q };
                if (angular.isDefined(offset)) { data.offset = offset; }
                if (category.name !== "Alla") { data.category = category.uuid; }
                if (license.name !== "Alla") { data.license = license.uuid; }
                Resource.get(data, scopeResult, Alert.error('Resource'));
                $location.path('/');
            };

        if ($routeParams.id) {
            Resource.get({ tag: $routeParams.id }, scopeResult, Alert.error('Resource'));
            Tag.get({ id: $routeParams.id }, function (res) {
                $scope.tag = res;
            }, Alert.error('Tag'));
        } else {
            Resource.get(scopeResult, Alert.error('Resource'));
        }

        // Search
        $scope.$on("search-query", function (e, query) {
            if (angular.isDefined(query)) {
                q = query;
                getResource();
            }
        });

        // Pagination
        $scope.currentPage = 0;

        $scope.$watch('currentPage', function (curr, prev) {
            if (curr !== prev) { getResource(curr * 10); }
        });

        $scope.range = function (n) {
            return Array.apply(null, [].constructor(n))
                        .map(function (x, i) { return i; });
        };

        $scope.prevPage = function () {
            if ($scope.currentPage > 0) {
                $scope.currentPage -= 1;
            }
        };

        $scope.nextPage = function () {
            if ($scope.currentPage < $scope.pages - 1) {
                $scope.currentPage += 1;
            }
        };

        $scope.setPage = function () {
            $scope.currentPage = this.n;
        };

        // Select category
        ResourceTypes.get(function (res) {
            $scope.category = category;
            res.items.push(category);
            $scope.categories = res.items;
        }, Alert.error('ResourceTypes'));

        $scope.$watch('category', function (curr, prev) {
            if (angular.isDefined(prev) && (prev !== curr)) {
                category = curr;
                getResource();
            }
        });

        // Select license
        License.get(function (res) {
            $scope.license = license;
            res.items.push(license);
            $scope.licenses = res.items;
        }, Alert.error('License'));

        $scope.$watch('license', function (curr, prev) {
            if (angular.isDefined(prev) && (prev !== curr)) {
                license = curr;
                getResource();
            }
        });
    }]);
