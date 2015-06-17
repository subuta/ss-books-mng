app = angular.module "kaizenBooksMng"
app.controller "AddBooksCtrl", ($scope, Books) ->
  vm = @
  vm.books = Books.gets()
  return @
