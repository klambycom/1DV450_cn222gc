/*global app, console, Date */

app.config(['$translateProvider', '$routeProvider', '$locationProvider',
            'AuthorizationProvider', 'APIUrlProvider',
    function ($translateProvider, $routeProvider, $locationProvider,
              AuthorizationProvider, APIUrlProvider) {

        'use strict';

        console.log(new Date());

        // API
        AuthorizationProvider
            .setApplicationId('98540e836d1cb2ea0c0a6e2258bcbd3efec7fc22ef7c7d8b31745d192706fe3c');

        APIUrlProvider
            .users('http://api.lvh.me:3000/users/:id')
            .resources('http://api.lvh.me:3000/resources/:id')
            .licenses('http://api.lvh.me:3000/licenses/:id')
            .resourceTypes('http://api.lvh.me:3000/resource_types/:id')
            .tags('http://api.lvh.me:3000/tags/:id')
            .login('http://lvh.me:3001/auth/toerh_doorkeeper');

        // Routes
        $routeProvider
            .when('/', {
                templateUrl: '/assets/resources.html',
                controller:  'ResourcesController'
            })
            .when('/resources/new', {
                templateUrl: '/assets/new.html',
                controller:  'EditController'
            })
            .when('/resources/:id', {
                templateUrl: '/assets/show.html',
                controller:  'DetailsController'
            })
            .when('/resources/:id/edit', {
                templateUrl: '/assets/edit.html',
                controller:  'EditController'
            })
            .when('/search?q=:query', {
                templateUrl: '/assets/resources.html',
                controller:  'ResourcesController'
            })
            .otherwise({ redirectTo: '/' });

        $locationProvider.html5Mode(true);

        // Translations
        // http://angular-translate.github.io/
        $translateProvider.useStaticFilesLoader({
            prefix: '/assets/locale-',
            suffix: '.json'
        });

        //$translateProvider.useLocalStorage();
        $translateProvider.preferredLanguage('en');
    }]);
