app = angular.module "ssBooksMng"
app.controller "NavbarCtrl", ($scope, $state, _, Shops) ->
  vm = @
  vm.getClass = (state) ->
    return {
      'is-active': $state.is(state)
    }
  Shops.gets({}, (shops) ->
    vm.shops = shops
    vm.shop = _.first(vm.shops)
  )
  return @
