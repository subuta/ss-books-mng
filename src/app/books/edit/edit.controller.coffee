app = angular.module "ssBooksMng"
app.controller "EditBooksCtrl", ($q, $state, $timeout, _, book, Books, toastr, authors, ModalService) ->
  vm = @
  vm.book = book
  vm.isPageLoaded = false

  # 本と著者一覧の取得が完了したら
  $q.all([book.$promise, authors.$promise]).then(
    (results) ->
      [_book, authors] = results
      vm.authors = authors
      # 本の著者を取得する。
      vm.author = _.findWhere(vm.authors, {id: Number(vm.book.author_id)})
      vm.isPageLoaded = true
  )

  vm.copyBook = ->
    $state.go('books.add', { templateId: Number(vm.book.id)} )

  vm.updateBook = ->
    vm.book.author_id = vm.author.id
    vm.book.$save().then( (res) ->
      console.log "book '#{res.title}'(id = #{res.id}}) updated."
      toastr.success("'#{res.title}'を更新しました。", 'Success')
    )

  vm.deleteBook = ->
    question = {
      title: '本当に削除してもよろしいですか？'
      content: '''
        この操作は取り消すことが出来ません。対象が正しいかどうか
        ご確認いただき、正しければ"はい"ボタンを押してください。
        (取り消す場合は"いいえ"を押してください。)
      '''
    }
    ModalService.confirm(question).then( (result) ->
      if result
        vm.book.$delete().then( ->
          console.log "book '#{vm.book.title}'(id = #{vm.book.id}}) deleted."
          toastr.success("'#{vm.book.title}'を削除しました。", 'Success')
          $state.go('books.list')
        )
    )

  vm.cancel = ->
    $state.go('books.list')

  return @
