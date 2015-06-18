app = angular.module "kaizenBooksMng"
app.controller "NavbarCtrl", ($scope, $state, Shops) ->
  vm = @
  vm.page = 1
  vm.getClass = (state) ->
    return {
      'is-active': $state.is(state)
    }
  Shops.gets({}, (shops) ->
    vm.shops = shops
    console.log vm.shops
  )
  return @
