app = angular.module "kaizenBooksMng"
app.controller "EditBooksCtrl", ($q, _, book, Books, authors) ->
  vm = @
  vm.book = book

  # 本と著者一覧の取得が完了したら
  $q.all([book.$promise, authors.$promise]).then(
    (results) ->
      [_book, authors] = results
      vm.authors = authors
      # 本の著者を取得する。
      vm.author = _.findWhere(vm.authors, {id: Number(vm.book.author_id)})
  )

  vm.updateBook = ->
    console.log 'start!'

#    _book = new Books()
#    _book.title = 'test'
#    _book.author_id = 3

#    '{"title": "Parallel Computing", "author_id": 3}'

#    res = _book.$create().$promise.then( ->
#      console.log res
#      console.log 'yay created!!'
#    )

    vm.book.$delete().$promise.then( ->
      console.log 'yay created!!'
    )
    console.log 'yay!'

  return @
