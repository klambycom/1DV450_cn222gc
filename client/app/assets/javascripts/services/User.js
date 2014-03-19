/*global app, angular */

app.factory('User', ['$resource', '$window', 'Authorization',
    function ($resource, $window, Authorization) {
        'use strict';

        var User = $resource('http://api.lvh.me:3000/users/:id', { id: '@id' }, {
            'me':  { method: 'GET', headers: Authorization.bearer() },
            'get': { method: 'GET', headers: Authorization.token() }
        });

        User.authenticated = Authorization.isAuthenticated();

        User.login = function () {
            $window.location.href = "http://lvh.me:3001/auth/toerh_doorkeeper";
        };

        User.logout = function () {
            User.authenticated = false;
            Authorization.removeAuthentication();
        };

        return User;
    }]);
