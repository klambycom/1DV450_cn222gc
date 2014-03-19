/*global app */

app.factory('User', ['$resource', 'Authorization',
    function ($resource, Authorization) {
        'use strict';

        return $resource('http://api.lvh.me:3000/users/:id', { id: '@id' }, {
            'me':  { method: 'GET', headers: Authorization.bearer() },
            'get': { method: 'GET', headers: Authorization.token() }
        });
    }]);
