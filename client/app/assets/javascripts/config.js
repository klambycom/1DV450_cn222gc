/*global app */

app.config(['$translateProvider', 'AuthorizationProvider', 'APIUrlProvider',
    function ($translateProvider, AuthorizationProvider, APIUrlProvider) {
        'use strict';

        AuthorizationProvider
            .setApplicationId('98540e836d1cb2ea0c0a6e2258bcbd3efec7fc22ef7c7d8b31745d192706fe3c');

        APIUrlProvider
            .users('http://api.lvh.me:3000/users/:id')
            .resources('http://api.lvh.me:3000/resources/:id')
            .licenses('http://api.lvh.me:3000/licenses/:id')
            .resourceTypes('http://api.lvh.me:3000/resource_types/:id')
            .tags('http://api.lvh.me:3000/tags/:id')
            .login('http://lvh.me:3001/auth/toerh_doorkeeper');

        // http://www.ng-newsletter.com/posts/angular-translate.html
        // http://angular-translate.github.io
        $translateProvider.translations('en', {
            'ALERT': {
                'Resource': {
                    '401': 'Error loading resources because not authorized!',
                    '404': 'Could not find the resource.'
                },
                'User': {
                    '401': 'Error loading user because not authorized!'
                }
            }
        });

        $translateProvider.preferredLanguage('en');
    }]);
