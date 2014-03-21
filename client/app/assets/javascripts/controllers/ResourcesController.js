/*global angular, app */

app.controller('ResourcesController', ['$scope', 'Resource', 'ResourceTypes', 'Alert',
    function ($scope, Resource, ResourceTypes, Alert) {
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
            getResource = function (offset) {
                var data = { q: q };
                if (angular.isDefined(offset)) { data.offset = offset; }
                if (category.name !== "Alla") { data.category = category.uuid; }
                Resource.get(data, scopeResult, Alert.error('Resource'));
            };

        Resource.get(scopeResult, Alert.error('Resource'));

        // Search
        $scope.$on("search-query", function (e, query) {
            q = query;
            getResource();
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
            $scope.category = { name: "Alla", uuid: "alla" };
            res.items.push($scope.category);
            $scope.categories = res.items;
        }, Alert.error('ResourceTypes'));

        $scope.$watch('category', function (curr, prev) {
            if (angular.isDefined(prev) && (prev !== curr)) {
                category = curr;
                getResource();
            }
        });
    }]);
