angular.module "kaizenBooksMng"
  .controller "NavbarCtrl", ($scope, $state) ->
    vm = @

    vm.isIn = (state) ->
      return $state.is(state)
