/*global app, angular */

app.controller('MainController', ['$scope', '$timeout', function ($scope, $timeout) {
    'use strict';

    var alertTimeout;
    
    $scope.showAlert = false;

    $scope.$on('alert', function (e, msg) {
        if (angular.isDefined(alertTimeout)) {
            $timeout.cancel(alertTimeout);
        }

        $scope.message = msg;
        $scope.showAlert = true;

        alertTimeout = $timeout(function () {
            $scope.showAlert = false;
            $scope.message = {};
        }, 5000);
    });
}]);
