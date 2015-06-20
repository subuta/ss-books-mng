# Angularjs Directive Of Waves
# from: https://github.com/fians/Waves

app = angular.module "kaizenBooksMng"
app.directive 'ssNavbar', () ->
  controllerAs: 'vm'
  replace: true
  transclude: true
  restrict: 'E'
  scope: true
  templateUrl: 'components/navbar/navbar.html'
  controller: 'NavbarCtrl'
  link: (scope, elem, attr, ctrl, $transclude) ->
    # 親子構造を崩さないように、transcludeする要素とng-transcludeをreplaceする。
    $transclude (clone, scope) ->
      transcludeElem = elem.find('[ng-transclude]')
      if clone.length
        transcludeElem.replaceWith(clone)
      else
        transcludeElem.remove()
