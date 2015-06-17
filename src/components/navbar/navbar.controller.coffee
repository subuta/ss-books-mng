app = angular.module "kaizenBooksMng"
app.controller "NavbarCtrl", ($scope, $state) ->
  $scope.page = 1
  $scope.getClass = (state) ->
    return {
      'is-active': $state.is(state)
    }
  return @
