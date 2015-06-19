app = angular.module "kaizenBooksMng"

Books = ($resource, routes) ->
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
      headers: {
        'Content-Type': 'application/json'
      }
    save:
      method: 'POST'
  }

  $resource(url, defaultParams, actions)

app.factory('Books', Books)
