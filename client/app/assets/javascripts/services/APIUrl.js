/*global app, angular */

app.provider('APIUrl', function () {
    'use strict';

    var self = this, urls = {}, set;

    set = function (key) {
        return function (url) {
            urls[key] = url;
            return self;
        };
    };

    this.users = set('users');
    this.resources = set('resources');
    this.licenses = set('licenses');
    this.resourceTypes = set('resourceTypes');
    this.tags = set('tags');
    this.login = set('login');

    this.$get = function () {
        return urls;
    };
});
