/*global app */

app.factory('Resource', ['$resource', 'Authorization', 'APIUrl',
    function ($resource, Authorization, APIUrl) {
        'use strict';

        return $resource(APIUrl.resources, { id: '@id', q: '@q' }, {
            'get':    { method: 'GET',    headers: Authorization.token() },
            'save':   { method: 'POST',   headers: Authorization.bearer() },
            'update': { method: 'PUT',    headers: Authorization.bearer() },
            'query':  { method: 'GET',    headers: Authorization.token() },
            'delete': { method: 'DELETE', headers: Authorization.bearer() }
        });
    }]);
