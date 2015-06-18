app = angular.module "kaizenBooksMng"
app.controller "NavbarCtrl", ($scope, $state) ->
  vm = @
  vm.page = 1
  vm.getClass = (state) ->
    return {
      'is-active': $state.is(state)
    }
  return @
