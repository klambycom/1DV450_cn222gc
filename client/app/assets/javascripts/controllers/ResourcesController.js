/*global angular, app */

app.controller('ResourcesController', ['$scope', 'Resource', 'Alert',
    function ($scope, Resource, Alert) {
        'use strict';

        var dot = function (a) { return function (b) { return b[a]; }; },
            flatten = function (a) { return [].concat.apply([], a); },
            scopeResult = function (res) {
                $scope.resources = res.items;
                $scope.meta = res.meta;
                $scope.categories = res.items.map(dot('resource_type'));
                $scope.tags = flatten(res.items.map(dot('tags')));

                $scope.pages = Math.ceil($scope.meta.length / $scope.meta.limit);
            },
            q = "";

        Resource.get(scopeResult, Alert.error('Resource'));

        // Search
        $scope.$on("search-query", function (e, query) {
            q = query;
            Resource.get({ q: query }, scopeResult, Alert.error('Resource'));
        });

        // Pagination
        $scope.currentPage = 0;

        $scope.$watch('currentPage', function (curr, prev) {
            Resource.get({ q: q, offset: curr * 10 }, scopeResult, Alert.error('Resource'));
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
    }]);
