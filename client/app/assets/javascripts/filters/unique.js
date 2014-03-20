/*global angular, app */

app.filter('unique', function () {
    'use strict';

    return function (items, filter) {
        var dotFilter = function (item) {
                if (angular.isObject(item) && angular.isString(filter)) {
                    return item[filter];
                }
                return item;
            },
            eqFilter = function (x) {
                return function (y) { return dotFilter(x) === dotFilter(y); };
            };

        if (angular.isArray(items)) {
            return items.reduce(function (acc, x) {
                if (!acc.some(eqFilter(x))) { acc.push(x); }
                return acc;
            }, []);
        }
    };
});
