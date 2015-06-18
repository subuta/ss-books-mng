app = angular.module "kaizenBooksMng", [
  'ngAnimate',
  'ngCookies',
  'ngTouch',
  'ngMdIcons',
  'ngSanitize',
  'ngResource',
  'ui.router',
  'ngFx',
  'ngProgress'
]

# 進捗表示用
app.factory "HttpProgressInterceptor", ($injector) ->
  that = @
  @onGoingRequests = {}

  getNgProgress = ->
    ngProgress = ngProgress || $injector.get("ngProgress")
    ngProgress.color('#00DAA0')
    ngProgress.height('2px');
    return ngProgress

  completeProgress = () ->
    ngProgress = getNgProgress()
    keys = Object.keys(that.onGoingRequests)
    if keys.length == 0
      console.log 'done!'
      ngProgress.complete()

  resetProgress = () ->
    ngProgress = getNgProgress()
    ngProgress.reset()
    that.onGoingRequests = {}

  return {
    'request': (config) ->
      targetUrl = config?.url
      that.onGoingRequests[targetUrl] = true
      ngProgress = getNgProgress()
      ngProgress.reset()
      ngProgress.start()
      return config

    'requestError': (rejection) ->
      resetProgress()
      return rejection

    'response': (response) ->
      targetUrl = response.config?.url
      delete that.onGoingRequests[targetUrl]
      completeProgress()
      return response

    'responseError': (rejection) ->
      resetProgress()
      return rejection
    }

app.config ($stateProvider, $urlRouterProvider, $httpProvider) ->
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

  # HTTPリクエストをインターセプトする。
  $httpProvider.interceptors.push('HttpProgressInterceptor');


app.run ($rootScope) ->
