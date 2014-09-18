angular.module 'webapp', [
  'ui.bootstrap'
  'ui.router'
  'webapp.header'
  'webapp.pages'
  'webapp-templates'
]

.config Array '$stateProvider', ($stateProvider) -> 
  $stateProvider
    .state 'home',
      controller: 'PageController'
      templateUrl: '/webapp/home/home.html'
      url: '/'

.config Array '$locationProvider', ($locationProvider) ->
  $locationProvider.html5Mode(true)
  $locationProvider.hashPrefix = "!"

.run Array '$rootScope', '$window', ($rootScope, $window) ->
  $rootScope.signIn = () ->
    $window.location.href = '/api/auth/google'
