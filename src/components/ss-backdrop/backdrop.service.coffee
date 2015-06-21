app = angular.module "kaizenBooksMng"
app.factory('BackdropService', (_) ->
  new class BackdropService
    constructor: ->
      @isShow = false
      @isIgnoreHide = false
      @handlers = []
      @clickHandlers = []

      # 背景のクリック時にモーダルを隠す様にする。
      @onClick( => @hide() unless @isIgnoreHide )

    click: (event = null) ->
      unless _.isEmpty(@clickHandlers)
        _.each(@clickHandlers, (handler) ->
          handler(event)
        )

    onClick: (func = null) ->
      if func
        @clickHandlers.push(func)
      else
        @clickHandlers = []

    removeOnClick: (func) ->
      @clickHandlers = _.without(@clickHandlers, func)

    show: (isIgnoreHide = false) ->
      @isShow = true
      @isIgnoreHide = isIgnoreHide
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
      @isIgnoreHide = false
      @_callHandler()

    onHide: (func = null) ->
      if func
        @handlers.push(func)
      else
        @handlers = []
)
