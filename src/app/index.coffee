app = angular.module "kaizenBooksMng", [
  'ngAnimate',
  'ngCookies',
  'ngTouch',
  'ngMdIcons',
  'ngSanitize',
  'ngResource',
  'ui.router',
  'ngFx'
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
      controllerAs: 'vm',
      resolve:
        BooksService: 'Books',
        books: (BooksService) ->
          return BooksService.gets()
    .state 'books.add',
      url: "/add",
      templateUrl: "app/books/add/add.html",
      controller: "AddBooksCtrl"
      controllerAs: 'vm'

  $urlRouterProvider.otherwise '/books/list'

app.run ($window) ->
  $window.paceOptions =
    document: true,
    eventLag: true,
    restartOnPushState: false,
    restartOnRequestAfter: false,
    ajax:
      trackMethods: [ 'POST','GET']
