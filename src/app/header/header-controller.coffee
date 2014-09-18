angular
  .module 'webapp.header'
  .controller 'HeaderController', Array '$scope', '$location', ($scope, $location) ->
    'use strict'

    $scope.isActive = (viewLocation) ->
      viewLocation == $location.path()