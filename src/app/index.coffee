app = angular.module "kaizenBooksMng", [
  'ngAnimate',
  'ngCookies',
  'ngTouch',
  'ngMdIcons',
  'ngSanitize',
  'ngResource',
  'ui.router'
]

app.config ($stateProvider, $urlRouterProvider) ->
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
      .state 'books.add',
        url: "/add",
        templateUrl: "app/books/add/add.html",
        controller: "AddBooksCtrl"
        controllerAs: 'vm'

    $urlRouterProvider.otherwise '/books/list'

app.run () ->
  console.log 'run!'
