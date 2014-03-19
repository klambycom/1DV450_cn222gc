/*global angular, app, console, window */

app.controller('UserController', function ($scope, User, AlertFactory) {
    'use strict';

    $scope.isSignedIn = false;

    $scope.login = function () {
        window.location.href = "http://lvh.me:3001/auth/toerh_doorkeeper";
    };

    User.me(function (res) {
        $scope.user = {
            'uuid': res.uuid,
            'name': res.firstname + " " + res.lastname,
            'firstname': res.firstname,
            'lastname': res.lastname,
            'email': res.email
        };
        $scope.isSignedIn = true;
    }, AlertFactory.error('Resource'));
});
