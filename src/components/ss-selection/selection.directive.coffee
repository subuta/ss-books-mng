# Angularjs Directive Of Waves
# from: https://github.com/fians/Waves

app = angular.module "kaizenBooksMng"
app.directive 'ssSelection', (BackdropService) ->
  replace: true
  restrict: 'E'
  require: ['ngModel']
  scope: {
    selections: '='
    selectionProp: '@'
    selectionVal: '@'
    ssLabel: '@'
    ngModel: '='
    ngDisabled: '='
    ssAddOn: '@'
    isNarrow: '@'
  }
  template: '''
      <div ng-class="getWrapperClass()">
        <label class="ss-input-label">{{ssLabel}}</label>
        <input ng-model="ngModel" class="ss-selection-input" ng-disabled="ngDisabled" ng-click="toggleSelection()"/>
        <span class="ss-selection-addon" ng-click="toggleSelection()">
          <ng-md-icon icon="arrow_drop_down" size="24"></ng-md-icon>
        </span>
        <ul class="ss-selection" ng-show="isExpand">
          <li class="ss-selection-item" ng-click="select()">-- 指定なし --</li>
          <li class="ss-selection-item" ng-repeat="selection in selections" ng-click="select(selection)" ng-bind="selection[selectionProp]"></li>
        </ul>
      </div>
  '''
  controller: ($scope, hotkeys) ->
    $scope.isExpand = false

    $scope.$watch('isExpand', (isExpand) ->
      if isExpand
        BackdropService.show()
      else
        BackdropService.hide()
    )

    hotkeys.add(
      combo: 'esc',
      allowIn: ['INPUT']
      description: 'Hide Selection',
      callback: -> $scope.closeSelection()
    )

    # backdrop部分のクリック時
    onBackdropClick = (event) ->
      $scope.closeSelection() # 選択を終了する。

    BackdropService.onClick(onBackdropClick)

    $scope.toggleSelection =  ->
      $scope.isExpand = !$scope.isExpand

    $scope.closeSelection = ->
      $scope.isExpand = false

    $scope.getWrapperClass = ->
      return {
        'ss-selection-wrapper': true
        'is-disabled': $scope.ngDisabled
      }

    $scope.select = (selection = null) ->
      # selectionValが指定されていたら、それを利用する・
      if selection
        prop = if $scope.selectionVal then $scope.selectionVal else $scope.selectionProp
        $scope.ngModel = selection[prop]
      else
        $scope.ngModel = null

      $scope.closeSelection()
