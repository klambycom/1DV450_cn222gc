/*global app, angular */

app.provider('Authorization', function () {
    'use strict';

    var cookieKey = 'access_token', applicationId;

    this.setCookieKey = function (key) { cookieKey = key; };
    this.setApplicationId = function (id) { applicationId = id; };

    this.$get = ['$cookies', function ($cookies) {
        return {
            token: function () {
                return { 'Authorization': 'Token token=' + applicationId };
            },
            bearer: function () {
                return { 'Authorization': 'Bearer ' + $cookies[cookieKey] };
            },
            removeAuthentication: function () {
                delete $cookies[cookieKey];
            },
            isAuthenticated: function () {
                return angular.isDefined($cookies[cookieKey]);
            }
        };
    }];
});
