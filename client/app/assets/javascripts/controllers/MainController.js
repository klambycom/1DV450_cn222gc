/*global app, angular */

app.controller('MainController', ['$scope', '$timeout', '$location', 'User', 'Alert',
    function ($scope, $timeout, $location, User, Alert) {
        'use strict';

        var alertTimeout, queryTimeout;
        
        // Messages
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

        // User
        $scope.login = User.login;

        $scope.logout = function () {
            $scope.user = { isAuthenticated: false };
            Alert.success('ALERT.User.Logout');
            User.logout();
        };

        if (User.authenticated) {
            User.me(function (res) {
                $scope.user = {
                    'uuid': res.uuid,
                    'name': res.firstname + " " + res.lastname,
                    'firstname': res.firstname,
                    'lastname': res.lastname,
                    'email': res.email,
                    'isAdmin': res.admin,
                    'isAuthenticated': true
                };
            }, Alert.error('User'));
        }

        // Search - with 200 ms delay
        $scope.$watch('query', function () {
            if (angular.isDefined(queryTimeout)) {
                $timeout.cancel(queryTimeout);
            }

            queryTimeout = $timeout(function () {
                $scope.$broadcast("search-query", $scope.query);
            }, 200);

            if (angular.isDefined($scope.query) && $scope.query.length > 0) {
                $location.path('/');
            }
        });
    }]);
