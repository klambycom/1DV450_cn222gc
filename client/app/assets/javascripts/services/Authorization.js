/*global app, angular */

app.provider('Authorization', function () {
    'use strict';

    var cookieKey = 'access_token', applicationId, accessToken;

    this.setCookieKey = function (key) {
        cookieKey = key;
    };

    this.setApplicationId = function (id) {
        applicationId = id;
    };

    this.$get = ['$cookies', function ($cookies) {
        return {
            token: function () {
                return { 'Authorization': 'Token token=' + applicationId };
            },
            bearer: function () {
                if (angular.isUndefined(accessToken)) {
                    accessToken = $cookies[cookieKey];
                }

                return { 'Authorization': 'Bearer ' + accessToken };
            }
        };
    }];
});
