/*global app */

app.factory('Resource', ['$resource', 'Authorization', 'APIUrl',
    function ($resource, Authorization, APIUrl) {
        'use strict';

        return $resource(APIUrl.resources, { id: '@id' }, {
            'get':	  { method: 'GET', headers: Authorization.token() },
            'save':	  { method: 'POST' },
            'query':  { method: 'GET', headers: Authorization.token() },
            'remove': { method: 'DELETE' },
            'delete': { method: 'DELETE' }
        });
    }]);
