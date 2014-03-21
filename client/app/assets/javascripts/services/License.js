/*global app */

app.factory('License', ['$resource', 'Authorization', 'APIUrl',
    function ($resource, Authorization, APIUrl) {
        'use strict';

        return $resource(APIUrl.licenses, { id: '@id' }, {
            'get':	  { method: 'GET',  headers: Authorization.token() },
            'save':	  { method: 'POST', headers: Authorization.bearer() },
            'query':  { method: 'GET',  headers: Authorization.token() }
        });
    }]);
