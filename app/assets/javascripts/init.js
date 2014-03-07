/*global angular, ResourcesController, ResourceDetailsController */

var app = angular.module('TOERH', ['ngResource', 'pascalprecht.translate']);

app.config(function ($routeProvider, $translateProvider) {
    'use strict';

    $routeProvider
        .when('/', {
            templateUrl: 'templates/resources/index.html',
            controller: ResourcesController
        })
        .when('/resource/new', {
            templateUrl: 'templates/resources/index.html',
            controller: ResourcesController
        })
        .when('/resource/:id', {
            templateUrl: 'templates/resources/show.html',
            controller: ResourceDetailsController
        })
        .when('/resource/:id/edit', {
            templateUrl: 'templates/resources/show.html',
            controller: ResourceDetailsController
        })
        .otherwise({ redirectTo: '/' });

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
});
