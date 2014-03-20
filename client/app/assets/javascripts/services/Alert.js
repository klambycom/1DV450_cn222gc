/*jslint es5: true */
/*global app, console */

app.factory('Alert', ['$filter', '$translate', '$rootScope',
    function ($filter, $translate, $rootScope) {
        'use strict';

        var createAlert = function (type) {
                return function (message) {
                    $rootScope.$broadcast('alert', {
                        type: type,
                        message: message
                    });
                };
            },
            noTranslation = function (message) {
                console.log('No translation for "' + message + '".');
            };

        return {
            error: function (type) {
                return function (error) {
                    $translate('ALERT.' + type + '.' + error.status)
                        .then(createAlert('error'))
                        .catch(noTranslation);
                };
            },
            info: function (key) {
                $translate(key)
                    .then(createAlert('info'))
                    .catch(noTranslation);
            },
            warning: function (key) {
                $translate(key)
                    .then(createAlert('warning'))
                    .catch(noTranslation);
            },
            success: function (key) {
                $translate(key)
                    .then(createAlert('success'))
                    .catch(noTranslation);
            }
        };
    }]);
