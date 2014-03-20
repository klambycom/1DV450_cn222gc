/*jslint es5: true */
/*global app, console, alert */

app.factory('Alert', ['$filter', '$translate', function ($filter, $translate) {
    'use strict';

    var createAlert = function (type) {
            return function (message) {
                console.log(type + '! ' + message);
            };
        },
        noTranslation = function (message) {
            alert('No translation for "' + message + '".');
        };

    return {
        error: function (type) {
            return function (error) {
                $translate('ALERT.' + type + '.' + error.status)
                    .then(createAlert('ERROR'))
                    .catch(noTranslation);
            };
        },
        info: function (key) {
            $translate(key)
                .then(createAlert('INFO'))
                .catch(noTranslation);
        },
        warning: function (key) {
            $translate(key)
                .then(createAlert('WARNING'))
                .catch(noTranslation);
        },
        success: function (key) {
            $translate(key)
                .then(createAlert('SUCCESS'))
                .catch(noTranslation);
        }
    };
}]);
