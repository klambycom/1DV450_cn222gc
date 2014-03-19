/*global app */

app.factory('Resource', ['$resource', 'Authorization',
    function ($resource, Authorization) {
        'use strict';

        return $resource('http://api.lvh.me:3000/resources/:id', { id: '@id' }, {
            'get':	  { method: 'GET', headers: Authorization.token() },
            'save':	  { method: 'POST' },
            'query':  { method: 'GET', headers: Authorization.token() },
            'remove': { method: 'DELETE' },
            'delete': { method: 'DELETE' }
        });
    }]);
