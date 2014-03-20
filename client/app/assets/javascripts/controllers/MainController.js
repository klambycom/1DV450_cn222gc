/*global app, angular */

app.controller('MainController', ['$scope', '$timeout', 'User', 'Alert',
    function ($scope, $timeout, User, Alert) {
        'use strict';

        // Messages
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

        // User
        $scope.isAuthenticated = User.authenticated;

        $scope.login = User.login;

        $scope.logout = function () {
            $scope.isAuthenticated = false;
            User.logout();
        };

        if (User.authenticated) {
            User.me(function (res) {
                $scope.user = {
                    'uuid': res.uuid,
                    'name': res.firstname + " " + res.lastname,
                    'firstname': res.firstname,
                    'lastname': res.lastname,
                    'email': res.email
                };
            }, Alert.error('User'));
        }
    }]);
