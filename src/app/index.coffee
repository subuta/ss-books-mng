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
  'ngProgress'
]

# 進捗表示用
app.factory "HttpProgressInterceptor", ($injector) ->
  that = @
  @onGoingRequests = {}
  that.ngProgress = null
  that.BackdropService = null

  getBackdrop = ->
    that.BackdropService = that.BackdropService || $injector.get("BackdropService")
    return that.BackdropService;

  getNgProgress = ->
    that.ngProgress = that.ngProgress || $injector.get("ngProgress")
    that.ngProgress.color('#4597F5')
    that.ngProgress.height('2px')
    return that.ngProgress

  completeProgress = () ->
    ngProgress = getNgProgress()
    keys = Object.keys(that.onGoingRequests)
    if keys.length == 0
      BackdropService = getBackdrop()
      BackdropService.hide()
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

      BackdropService = getBackdrop()
      BackdropService.show()

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

app.config ($stateProvider, $urlRouterProvider, $httpProvider, $sceProvider, routes) ->
  $stateProvider
    .state 'books',
      url: '/books'
      abstract: true
      template: '<ui-view/>'
      resolve:
        BooksService: 'Books',
        AuthorsService: 'Authors',
        ShopsService: 'Shops',
        books: (BooksService) ->
          return BooksService.gets()
    .state 'books.list',
      url: "/list?page",
      templateUrl: "app/books/list/list.html",
      controller: "ListBooksCtrl"
      controllerAs: 'vm',
    .state 'books.add',
      url: "/add?templateId",
      templateUrl: "app/books/add/add.html",
      controller: "AddBooksCtrl"
      controllerAs: 'vm'
      resolve:
        authors: (AuthorsService) ->
          return AuthorsService.gets()
        book: (BooksService, $stateParams) ->
          # テンプレートID(コピー元)の指定があるなら、それをベースとする。
          if $stateParams.templateId
            _id = $stateParams.templateId
            return BooksService.get({id: Number(_id)})
          else
            # ないなら、新しいインスタンスとする。
            book = new BooksService()
            return book
    .state 'books.edit',
      url: "/edit/:id",
      templateUrl: "app/books/edit/edit.html",
      controller: "EditBooksCtrl"
      controllerAs: 'vm'
      resolve:
        authors: (AuthorsService) ->
          return AuthorsService.gets()
        book: (BooksService, $stateParams) ->
          _id = $stateParams.id
          return BooksService.get({id: Number(_id)})

  $urlRouterProvider.otherwise '/books/list'

  # HTTPリクエストをインターセプトする。
  $httpProvider.interceptors.push('HttpProgressInterceptor')

  # Reset headers to avoid OPTIONS request (aka preflight)
  commonHeader = {
    'Content-Type': 'application/json'
  }

  $httpProvider.defaults.headers.common = {}
  $httpProvider.defaults.headers.post = {
    'Content-Type': 'application/json'
  }
  $httpProvider.defaults.headers.put = {}
#  $httpProvider.defaults.headers.post = commonHeader
#  $httpProvider.defaults.headers.put = commonHeader
  $httpProvider.defaults.headers.patch = {}

  $sceProvider.enabled(false)

  # CORS関連対応
#  $sceDelegateProvider.resourceUrlWhitelist(
#    # Allow same origin resource loads.
#    'self',
#    'file://.*',
#    # Allow loading from our assets domain.  Notice the difference between * and **.
#    routes.base + '/**'
#  )

app.run ($rootScope) ->
