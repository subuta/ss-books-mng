angular.module "kaizenBooksMng"
  .controller "ListBooksCtrl", ($scope, Books) ->
    vm = @
    vm.books = Books.gets()
    console.log vm.books
