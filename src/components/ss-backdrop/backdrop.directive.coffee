# Angularjs Directive Of Waves
# from: https://github.com/fians/Waves

app = angular.module "kaizenBooksMng"
app.directive 'ssBackdrop', () ->
  controllerAs: 'vm'
  replace: false
  restrict: 'E'
  scope: {}
  template: '<div class="ss-backdrop" ng-show="vm.isShow"></div>'
  compile: (elem, attrs) ->
    angular.noop()
  controller: class
    constructor: (BackdropService) ->
      vm = @
      # Show/Hideの変更のハンドラ
      changeVisibleHandler = (isShow) ->
        vm.isShow = isShow
      # サービスにセットする。
      BackdropService.onShow(changeVisibleHandler)
      BackdropService.onHide(changeVisibleHandler)
      return vm