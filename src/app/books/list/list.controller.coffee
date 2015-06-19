app = angular.module "kaizenBooksMng"
app.controller "ListBooksCtrl", ($state, books, Authors) ->
  vm = @
  vm.books = books

  Authors.gets({}, (authors) ->
    vm.authors = authors
  )

  vm.goToEdit = (id) ->
    $state.go('books.edit', {id: Number(id)})

  return vm
