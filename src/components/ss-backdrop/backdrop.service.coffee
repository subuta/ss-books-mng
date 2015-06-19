app = angular.module "kaizenBooksMng"
app.factory('BackdropService', (_) ->
  new class BackdropService
    constructor: ->
      @isShow = false
      @handlers = []

    show: ->
      @isShow = true
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
      @isShow = false
      @_callHandler()

    onHide: (func = null) ->
      if func
        @handlers.push(func)
      else
        @handlers = []
)
