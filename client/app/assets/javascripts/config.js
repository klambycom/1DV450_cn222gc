/*global app, console, Date */

app.config(['$translateProvider', '$routeProvider', '$locationProvider',
            'AuthorizationProvider', 'APIUrlProvider',
    function ($translateProvider, $routeProvider, $locationProvider,
              AuthorizationProvider, APIUrlProvider) {

        'use strict';

        console.log(new Date());

        // API
        AuthorizationProvider
            .setApplicationId('14fcde9a04e4c630f5d2a7682723f9d698c8188492035a7d75a3b930fa609366');

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
            .when('/categories/new', {
                templateUrl: '/assets/newcategory.html',
                controller:  'AdminController'
            })
            .when('/licenses/new', {
                templateUrl: '/assets/newlicense.html',
                controller:  'AdminController'
            })
            .when('/tags/:id', {
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
        $translateProvider.preferredLanguage('sv');
    }]);
