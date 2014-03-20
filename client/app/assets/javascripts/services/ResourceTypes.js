/*global app */

app.factory('ResourceTypes', ['$resource', 'Authorization', 'APIUrl',
    function ($resource, Authorization, APIUrl) {
        'use strict';

        return $resource(APIUrl.resourceTypes, { id: '@id' }, {
            'get':	  { method: 'GET', headers: Authorization.token() },
            //'save':	  { method: 'POST' },
            'query':  { method: 'GET', headers: Authorization.token() }//,
            //'remove': { method: 'DELETE' },
            //'delete': { method: 'DELETE' }
        });
    }]);
