/*global app, angular */

app.factory('User', ['$resource', '$window', 'Authorization', 'APIUrl',
    function ($resource, $window, Authorization, APIUrl) {
        'use strict';

        var User = $resource(APIUrl.users, { id: '@id' }, {
            'me':  { method: 'GET', headers: Authorization.bearer() },
            'get': { method: 'GET', headers: Authorization.token() }
        });

        User.authenticated = Authorization.isAuthenticated();

        User.login = function () {
            $window.location.href = APIUrl.login;
        };

        User.logout = function () {
            User.authenticated = false;
            Authorization.removeAuthentication();
        };

        return User;
    }]);
