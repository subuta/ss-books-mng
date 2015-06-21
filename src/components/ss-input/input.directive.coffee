# Angularjs Directive Of Waves
# from: https://github.com/fians/Waves

app = angular.module "ssBooksMng"
app.directive 'ssInput', () ->
  replace: true
  restrict: 'E'
  require: ['ngModel']
  scope: {
    ssLabel: '@'
    ngModel: '='
    ngDisabled: '='
    ssAddOn: '@'
    isNarrow: '@'
  }
  template: '''
      <div ng-class="getWrapperClass()">
        <label class="ss-input-label">{{ssLabel}}</label>
        <input type="text" ng-model="ngModel" ng-class="getInputClass()" ng-disabled="ngDisabled"/>
        <span class="ss-input-addon" ng-show="ssAddOn">{{ssAddOn}}</span>
      </div>
  '''
  controller: ($scope) ->
    $scope.getInputClass = ->
      return {
        'ss-input': !$scope.isNarrow
        'ss-input-narrow': $scope.isNarrow
      }

    $scope.getWrapperClass = ->
      return {
        'ss-input-wrapper': true
        'is-disabled': $scope.ngDisabled
      }
