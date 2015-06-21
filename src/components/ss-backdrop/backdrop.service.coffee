app = angular.module "kaizenBooksMng"
app.factory('BackdropService', (_, hotkeys) ->
  new class BackdropService
    constructor: ->
      @isShow = false
      @isIgnoreHide = false
      @handlers = []
      @clickHandlers = []

      hotkeys.add(
        combo: 'esc',
        allowIn: ['INPUT']
        description: 'Hide Backdrop',
        callback: () => @hide() unless @isIgnoreHide
      )

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

    show: (ignoreEsc = false) ->
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
      @isShow = false
      @isIgnoreHide = false
      @_callHandler()

    onHide: (func = null) ->
      if func
        @handlers.push(func)
      else
        @handlers = []
)
