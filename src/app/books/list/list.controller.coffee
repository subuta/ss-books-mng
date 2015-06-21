app = angular.module "kaizenBooksMng"
app.controller "ListBooksCtrl", ($state, $stateParams, $filter, books, Authors, updateAtQueries) ->
  vm = @
  vm.perPage = 10
  vm.books = books
  vm.bookFilter = {}
  vm.updateAtFilters = updateAtQueries

  if $stateParams.page
    vm.currentPage = Number($stateParams.page)
  else
    vm.currentPage = 0

  # 現在のページの表示内容の開始インデックス
  vm.fromCount = ->
    # 現在のページが0の場合は、0を返す。
    _from = vm.currentPage * vm.perPage
    return if _from >= 1 then _from + vm.getPaginatedBooks().length - 1 else _from

  # 次・前のページの有無の確認用
  vm.hasNext = ->
    vm.getPaginatedBooks(vm.currentPage + 1).length > 0

  vm.hasPrevious = ->
    vm.currentPage > 0

  vm.getPaginatedBooks = (page = vm.currentPage) ->
    _books = vm.books
    _books = $filter('filter')(_books, { title: vm.bookFilter.title })
    _books = $filter('author')(_books, vm.authors, vm.bookFilter.authorName )
    _books = $filter('updateAt')(_books, vm.bookFilter.updatedAt)
    _books = $filter('offset')(_books, page * vm.perPage)
    _books = $filter('limitTo')(_books, vm.perPage)
    return _books

  # 1つでも
  vm.hasBooks = ->
    vm.getPaginatedBooks().length > 0

  Authors.gets({}, (authors) ->
    vm.authors = authors
  )

  vm.goToEdit = (id) ->
    $state.go('books.edit', {id: Number(id)})

  return vm
