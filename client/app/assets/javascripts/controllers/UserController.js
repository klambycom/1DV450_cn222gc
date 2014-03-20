/*global angular, app */

app.controller('UserController', ['$scope', 'User', 'Alert',
    function ($scope, User, Alert) {
        'use strict';

        $scope.isSignedIn = User.authenticated;

        $scope.login = User.login;

        $scope.logout = function () {
            $scope.isSignedIn = false;
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
