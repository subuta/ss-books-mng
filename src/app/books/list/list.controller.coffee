app = angular.module "kaizenBooksMng"
app.controller "ListBooksCtrl", ($state, $stateParams, $filter, books, Authors) ->
  vm = @
  vm.perPage = 1
  vm.books = books

  if $stateParams.page
    vm.currentPage = Number($stateParams.page)
  else
    vm.currentPage = 1

  # 現在のページの表示内容の開始インデックス
  vm.fromCount = ->
    return vm.currentPage * vm.perPage + vm.getPaginatedBooks().length - 1

  # 次・前のページの有無の確認用
  vm.hasNext = ->
    vm.getPaginatedBooks(vm.currentPage + 1).length > 0

  vm.hasPrevious = ->
    vm.currentPage > 1

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
