app = angular.module "ssBooksMng", [
  'ngAnimate',
  'ngCookies',
  'ngTouch',
  'ngAria',
  'ngMdIcons',
  'ngSanitize',
  'ngResource',
  'ui.router',
  'ngFx',
  'ngProgress',
  'cfp.hotkeys',
  'angularMoment',
  '720kb.tooltips'
]

app.run ($rootScope) ->
