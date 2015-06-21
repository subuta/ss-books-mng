app = angular.module "kaizenBooksMng"
app.controller "ListBooksCtrl", ($state, $stateParams, $filter, books, Authors) ->
  vm = @
  vm.perPage = 10
  vm.books = books

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
    pagedBooks = $filter('offset')(vm.books, page * vm.perPage)
    pagedBooks = $filter('limitTo')(pagedBooks, vm.perPage)
    return pagedBooks

  # 1つでも
  vm.hasBooks = ->
    vm.getPaginatedBooks().length > 0

  Authors.gets({}, (authors) ->
    vm.authors = authors
  )

  vm.goToEdit = (id) ->
    $state.go('books.edit', {id: Number(id)})

  return vm
