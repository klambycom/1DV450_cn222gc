/*global app */

app.directive('search', function () {
    'use strict';

    return {
        restrict: 'E',
        scope: {
            query: '=q',
            result: '='
        },
        templateUrl: '/assets/search.html'
    };
});
