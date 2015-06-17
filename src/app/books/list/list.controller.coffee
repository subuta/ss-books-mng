app = angular.module "kaizenBooksMng"
app.controller "ListBooksCtrl", ($scope, Books) ->
  vm = @
  vm.books = Books.gets()
  return vm
