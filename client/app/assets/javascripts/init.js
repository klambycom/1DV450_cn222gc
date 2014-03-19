/*global angular */

var app = angular.module('TOERH', [
        'ngResource',
        'ngCookies',
        'ngRoute',
        'pascalprecht.translate',
        'angular-md5',
        'angularMoment'
    ]);

app.run(['$window', function ($window) {
    'use strict';

    $window.moment.lang('sv');
}]);
