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
  '720kb.tooltips',
  'toastr'
]

app.run ($rootScope) ->
  $rootScope.$on('$stateChangeError', (event, toState, toParams, fromState, fromParams, error) ->
    console.log "error on state change. error = "
    console.log error
  )