/*global app */

app.factory('Resource', ['$resource', 'Authorization', 'APIUrl',
    function ($resource, Authorization, APIUrl) {
        'use strict';

        return $resource(APIUrl.resources, { id: '@id' }, {
            'get':	  { method: 'GET',    headers: Authorization.token() },
            'save':	  { method: 'POST',   headers: Authorization.bearer() },
            'query':  { method: 'GET',    headers: Authorization.token() },
            'remove': { method: 'DELETE', headers: Authorization.bearer() },
            'delete': { method: 'DELETE', headers: Authorization.bearer() }
        });
    }]);
