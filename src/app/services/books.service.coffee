app = angular.module "ssBooksMng"

Books = ($resource, routes, _) ->
  url = "#{routes.base}/books/:id.json"
  defaultParams = { id: '@id' }
  actions = {
    gets:
      method: 'GET'
      url: "#{routes.base}/books.json"
      isArray: true
    create:
      method: 'POST'
      url: "#{routes.base}/books.json"
      transformRequest: (data, headersGetter) ->
        # APIで許容しているプロパティのみをシリアライズして送信する。
        picked =  _.pick(data, 'title', 'author_id')
        return JSON.stringify(picked)
    save:
      method: 'PUT'
      transformRequest: (data, headersGetter) ->
        # APIで許容しているプロパティのみをシリアライズして送信する。
        picked =  _.pick(data, 'title', 'author_id')
        return JSON.stringify(picked)
  }

  $resource(url, defaultParams, actions)

app.factory('Books', [ '$resource', 'routes' , '_', Books ])