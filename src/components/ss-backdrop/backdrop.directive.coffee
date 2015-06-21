# Angularjs Directive Of Waves
# from: https://github.com/fians/Waves

app = angular.module "ssBooksMng"
app.directive 'ssBackdrop', () ->
  replace: false
  restrict: 'E'
  scope: {}
  template: '<div class="ss-backdrop fx-fade-normal fx-easing-back fx-speed-100" ng-show="isShow" ng-click="onBackdropClick($event)"></div>'
  compile: (elem, attrs) ->
    angular.noop()
  controller: ($scope, BackdropService, hotkeys) ->
    # Show/Hideの変更のハンドラ
    changeVisible = (isShow) ->
      $scope.isShow = isShow

    # サービスにセットする。
    BackdropService.onShow(changeVisible)
    BackdropService.onHide(changeVisible)

    $scope.onBackdropClick = (event) ->
      BackdropService.click(event)
