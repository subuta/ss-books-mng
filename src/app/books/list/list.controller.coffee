app = angular.module "kaizenBooksMng"
app.controller "ListBooksCtrl", ($scope, books) ->
  vm = @
  vm.books = books
  console.log vm.books
  return vm
