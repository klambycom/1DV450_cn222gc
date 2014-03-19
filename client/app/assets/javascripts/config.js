/*global app */

app.config(['$translateProvider', 'AuthorizationProvider',
    function ($translateProvider, AuthorizationProvider) {
        'use strict';

        AuthorizationProvider
            .setApplicationId('98540e836d1cb2ea0c0a6e2258bcbd3efec7fc22ef7c7d8b31745d192706fe3c');

        // http://www.ng-newsletter.com/posts/angular-translate.html
        // http://angular-translate.github.io
        $translateProvider.translations('en', {
            'ALERT': {
                'Resource': {
                    '401': 'Error loading resources because not authorized!',
                    '404': 'Could not find the resource.'
                }
            }
        });

        $translateProvider.preferredLanguage('en');
    }]);
