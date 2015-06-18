app = angular.module "kaizenBooksMng"
app.controller "ListBooksCtrl", ($scope, books, Authors) ->
  vm = @
  vm.books = books
  console.log vm.books
  Authors.gets({}, (authors) ->
    vm.authors = authors
  )
  return vm
