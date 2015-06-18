app = angular.module "kaizenBooksMng"

Authors = ($resource, routes) ->
  url = "#{routes.base}/authors/:id.json"
  defaultParams = { id: '@id' }
  actions = {
    gets:
      method: 'GET'
      url: "#{routes.base}/authors.json"
      isArray: true
  }

  $resource(url, defaultParams, actions)

app.factory('Authors', Authors)
