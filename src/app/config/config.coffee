app = angular.module "kaizenBooksMng"
app.config ($stateProvider, $urlRouterProvider, $httpProvider, $sceProvider, hotkeysProvider, routes) ->
  # ルーティングの設定
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

  # SCEを無効化
  $sceProvider.enabled(false)

  # ショートカット関連の設定
  hotkeysProvider.includeCheatSheet = false
  hotkeysProvider.useNgRoute = false

# CORS関連対応
#  $sceDelegateProvider.resourceUrlWhitelist(
#    # Allow same origin resource loads.
#    'self',
#    'file://.*',
#    # Allow loading from our assets domain.  Notice the difference between * and **.
#    routes.base + '/**'
#  )
