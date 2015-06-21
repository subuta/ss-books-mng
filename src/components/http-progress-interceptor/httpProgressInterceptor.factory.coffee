app = angular.module "ssBooksMng"

# 進捗表示用
app.factory "HttpProgressInterceptor", ($injector) ->
  that = @
  @onGoingRequests = {}
  that.ngProgress = null
  that.BackdropService = null

  getBackdrop = ->
    that.BackdropService = that.BackdropService || $injector.get("BackdropService")
    return that.BackdropService;

  getNgProgress = ->
    that.ngProgress = that.ngProgress || $injector.get("ngProgress")
    that.ngProgress.color('#4597F5')
    that.ngProgress.height('2px')
    return that.ngProgress

  completeProgress = () ->
    ngProgress = getNgProgress()
    keys = Object.keys(that.onGoingRequests)
    if keys.length == 0
      BackdropService = getBackdrop()
      BackdropService.hide()
      ngProgress.complete()

  resetProgress = () ->
    ngProgress = getNgProgress()
    ngProgress.reset()
    that.onGoingRequests = {}

  return {
  'request': (config) ->
    targetUrl = config?.url
    that.onGoingRequests[targetUrl] = true
    ngProgress = getNgProgress()
    ngProgress.reset()
    ngProgress.start()

    BackdropService = getBackdrop()
    BackdropService.show(true)

    return config

  'requestError': (rejection) ->
    resetProgress()
    return rejection

  'response': (response) ->
    targetUrl = response.config?.url
    delete that.onGoingRequests[targetUrl]
    completeProgress()
    return response

  'responseError': (rejection) ->
    resetProgress()
    return rejection
  }
