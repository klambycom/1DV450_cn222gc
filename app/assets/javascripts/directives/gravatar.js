/*jslint es5: true */
/*global app */

/*
 * Gravatar
 *
 * Usage:
 * email
 * hash
 * size    - default 80 (px)
 * default - 404 (default), mm, identicon, monsterid, wavatar, retro, blank or URL.
 * rating  - g, pg (default), r or x.
 * https
 *
 * Example:
 * <gravatar email="email" size="200" default="http://www.google.com/a img.jpg" https></gravatar>
 *
 */

app.directive('gravatar', ['md5', function (md5) {
    'use strict';

    function isSet(scope) {
        return function (attr) {
            return scope[attr] !== null && scope[attr] !== undefined && scope[attr] !== '';
        };
    }

    function eq(a) { return function (b) { return a === b; }; }
    function any(xs) { return xs.reduce(function (acc, x) { return x || acc; }, false); }

    return {
        restrict: 'E',
        scope: {
            email:   '=?',
            hash:    '=?',
            size:    '@?',
            default: '@?',
            rating:  '@?',
            url:     '@?',
            https:   '@?'
        },
        template: '<img src="{{url}}" />',
        link: function (scope, element, attrs) {
            var url, inScope = isSet(scope), haveAttr = isSet(attrs.$attr);

            // validate
            if (inScope('rating') && !any(['g', 'pg', 'r', 'x'].map(eq(scope.rating)))) {
                throw "Gravatar rating must be g, pg, r or x.";
            }

            if (inScope('email') && inScope('hash')) {
                throw "Gravatar need email OR hash, not both.";
            }

            if (!(inScope('email') || inScope('hash'))) {
                throw "Gravatar need email or hash.";
            }

            // url
            url = (haveAttr('https') ? 'https://secure.gravatar.com/avatar/'
                                     : 'http://www.gravatar.com/avatar/') +
                  (inScope('email') ? md5.createHash(scope.email.toLowerCase())
                                    : scope.hash) +
                  '?s=' + (inScope('size') ? scope.size : '80') +
                  '&r=' + (inScope('rating') ? scope.rating : 'pg') +
                  '&d=' + (inScope('default') ? encodeURIComponent(scope.default)
                                              : '404');

            // add all to src
            attrs.$set('src', url);
            scope.$watch(scope.url, function () { scope.url = url; });
        }
    };
}]);
