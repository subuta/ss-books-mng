app = angular.module "kaizenBooksMng"
app.controller "AddBooksCtrl", ($q, $state, _, book, authors) ->
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

  vm.addBook = (func = null) ->
    vm.book.$create().then( (res) ->
      console.log "book '#{res.title}' created."
      if func
        func(res)
      else
        $state.go('books.list')
    )

  vm.addAndCopyBook = ->
    vm.addBook (bookAdded) ->
      $state.go('books.add', { templateId: Number(bookAdded.id) })

  vm.cancel = ->
    $state.go('books.list')

  return @
