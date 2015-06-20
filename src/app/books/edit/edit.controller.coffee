app = angular.module "kaizenBooksMng"
app.controller "EditBooksCtrl", ($q, $state, _, book, Books, authors) ->
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

  vm.copyBook = ->
    $state.go('books.add', { templateId: Number(vm.book.id)} )

  vm.updateBook = ->
    vm.book.$save().then( (res) ->
      console.log "book '#{res.title}' updated."
    )

  vm.cancel = ->
    $state.go('books.list')

  return @
