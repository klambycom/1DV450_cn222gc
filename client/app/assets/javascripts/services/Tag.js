/*global app */

app.factory('Tag', ['$resource', 'Authorization', 'APIUrl',
    function ($resource, Authorization, APIUrl) {
        'use strict';

        return $resource(APIUrl.tags, { id: '@id' }, {
            'get': { method: 'GET',  headers: Authorization.token() }
        });
    }]);
