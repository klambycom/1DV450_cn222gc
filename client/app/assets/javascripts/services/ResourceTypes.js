/*global app */

app.factory('ResourceTypes', ['$resource', 'Authorization', 'APIUrl',
    function ($resource, Authorization, APIUrl) {
        'use strict';

        return $resource(APIUrl.resourceTypes, { id: '@id' }, {
            'get':	  { method: 'GET',  headers: Authorization.token() },
            'save':	  { method: 'POST', headers: Authorization.bearer() },
            'query':  { method: 'GET',  headers: Authorization.token() }
        });
    }]);
