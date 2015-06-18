app = angular.module "kaizenBooksMng"

Books = ($resource, routes) ->
  url = "#{routes.base}/books/:id.json"
  defaultParams = { id: '@id' }
  actions = {
    gets:
      method: 'GET'
      url: "#{routes.base}/books.json"
      isArray: true
  }

  $resource(url, defaultParams, actions)

app.factory('Books', Books)
