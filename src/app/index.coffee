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
      .state 'books',
        url: '/books'
        abstract: true
        template: '<ui-view/>'
      .state 'books.list',
        url: "/list",
        templateUrl: "app/books/list/list.html",
        controller: "ListBooksCtrl"
        controllerAs: 'vm'

    $urlRouterProvider.otherwise '/books/list'

