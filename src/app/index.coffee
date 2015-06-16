angular.module "kaizenBooksMng", [
  'ngAnimate',
  'ngCookies',
  'ngTouch',
  'ngMdIcons',
  'ngSanitize',
  'ngResource',
  'ui.router'
]
  .config ($stateProvider, $urlRouterProvider) ->
    $stateProvider
      .state "home",
        url: "/",
        templateUrl: "app/main/main.html",
        controller: "MainCtrl"

    $urlRouterProvider.otherwise '/'

