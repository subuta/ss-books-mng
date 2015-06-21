# Angularjs Directive Of Waves
# from: https://github.com/fians/Waves

app = angular.module "ssBooksMng"
app.directive 'ssSelection', (BackdropService) ->
  replace: true
  restrict: 'E'
  require: ['^ngModel']
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
        <input ng-model="ngModelLabel" class="ss-selection-input" ng-disabled="ngDisabled" ng-click="toggleSelection()"/>
        <span class="ss-selection-addon" ng-click="toggleSelection()">
          <ng-md-icon icon="arrow_drop_down" size="24"></ng-md-icon>
        </span>
        <ul class="ss-selection" ng-show="isExpand">
          <li class="ss-selection-item" ng-click="select()" ss-waves="block-dark">-- 指定なし --</li>
          <li class="ss-selection-item" ng-repeat="selection in selections" ng-click="select($index, selection)"
              ng-class="{ 'is-selected': isSelected($index) }" ng-bind="selection[selectionProp]" ss-waves="block-dark"></li>
        </ul>
      </div>
  '''
  controller: ($scope, hotkeys, _) ->
    $scope.isExpand = false
    $scope.selected = null
    $scope.ngModelLabel = ''

    $scope.$watch('isExpand', (isExpand) ->
      if isExpand
        BackdropService.show()
      else
        BackdropService.hide()
    )

    # selectが事前に呼び出されていないかどうかのチェック用関数
    isNotSelected = -> $scope.selected == null

    # 初めて親スコープでngModelが変更されたら
    ngModelListener = $scope.$watch('ngModel', (model) ->
      if model and isNotSelected()
        index = _.indexOf($scope.selections, model)
        $scope.select(index, model)
        ngModelListener() #選択後、キャンセルする。
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

    # 自身が選択済みの要素かどうかを調べる関数
    $scope.isSelected = (index) -> $scope.selected == index

    $scope.select = (index, selection = null) ->
      $scope.selected = index
      # selectionValが指定されていたら、それを利用する・
      if selection
        $scope.ngModelLabel = selection[$scope.selectionProp]
        if $scope.selectionVal
          if $scope.selectionVal == '$object'
            $scope.ngModel = selection
          else
            $scope.ngModel = selection[$scope.selectionVal]
        else
          $scope.ngModel = selection[$scope.selectionProp]
      else
        $scope.ngModelLabel = ""
        $scope.ngModel = null
      $scope.closeSelection()
