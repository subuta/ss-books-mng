app = angular.module "ssBooksMng"

Shops = ($resource, routes) ->
  url = "#{routes.base}/shops/:id.json"
  defaultParams = { id: '@id' }
  actions = {
    gets:
      method: 'GET'
      url: "#{routes.base}/shops.json"
      isArray: true
  }

  $resource(url, defaultParams, actions)

app.factory('Shops', Shops)
