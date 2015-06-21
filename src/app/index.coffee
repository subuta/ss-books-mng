app = angular.module "kaizenBooksMng", [
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
  'cfp.hotkeys'
]

app.run ($rootScope) ->
