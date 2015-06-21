# Angularjs Directive Of Waves
# from: https://github.com/fians/Waves

app = angular.module "kaizenBooksMng"
app.directive 'ssModal', () ->
  replace: false
  restrict: 'E'
  scope: {}
  templateUrl: 'components/ss-modal/modal.html'
  compile: (elem, attrs) ->
    angular.noop()
  controller: ($scope, $timeout, BackdropService, ModalService, hotkeys) ->
    # Show/Hideの変更のハンドラ
    changeVisible = (isShow) ->
      $scope.title = ModalService.modalTitle
      $scope.content = ModalService.modalContent
      $scope.isShow = isShow

    # サービスにセットする。
    ModalService.onShow(changeVisible)
    ModalService.onHide(changeVisible)

    # "はい"の場合
    $scope.yes = (event) ->
      ModalService.yes(event)

    # "いいえ"の場合
    $scope.no = (event) ->
      ModalService.no(event)
