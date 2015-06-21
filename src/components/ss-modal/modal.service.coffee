app = angular.module "kaizenBooksMng"
app.factory('ModalService', ($q, _, BackdropService) ->
  new class ModalService
    constructor: ->
      @isShow = false
      @isIgnoreHide = false
      @handlers = []
      @noHandler = _.noop
      @yesHandler = _.noop
      @modalTitle = ''
      @modalContent = ''

      # Backdropをクリックしたら非表示にする。
      BackdropService.onClick( =>
        @hide()
      )

    yes: (event = null) ->
      @yesHandler(event)

    onYes: (func = null) ->
      if func
        @yesHandler = func
      else
        @removeOnYes()

    removeOnYes: () ->
      @yesHandler = _.noop

    no: (event = null) ->
      @noHandler(event)

    onNo: (func = null) ->
      if func
        @noHandler = func
      else
        @removeOnNo()

    removeOnNo: () ->
      @noHandler = _.noop

    confirm: (question) ->
      deferred = $q.defer()

      @modalTitle = question.title
      @modalContent = question.content

      # Yes/Noのいずれかが呼ばれたら解決する。
      @onYes( ->
        deferred.resolve(true)
        @onYes() # resolve後は、空にする。
        @hide()
      )

      @onNo( ->
        deferred.resolve(false)
        @onNo() # resolve後は、空にする。
        @hide()
      )

      @show()

      return deferred.promise

    show: (ignoreEsc = false) ->
      BackdropService.show()
      @isShow = true
      @isIgnoreHide = ignoreEsc
      @_callHandler()

    _callHandler: ->
      unless _.isEmpty(@handlers)
        _.each(@handlers, (handler) =>
          handler(@isShow)
        )

    onShow: (func = null) ->
      if func
        @handlers.push(func)
      else
        @handlers = []

    hide: ->
      BackdropService.hide()
      @isShow = false
      @isIgnoreHide = false
      @_callHandler()

    onHide: (func = null) ->
      if func
        @handlers.push(func)
      else
        @handlers = []
)
