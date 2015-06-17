app = angular.module "kaizenBooksMng"
app.factory 'Books', ($resource) ->
  new class Books
    constructor: (@name = '') ->
      @_books = [
        { id: 1, name: '人間失格', imageUrl: 'http://lorempixel.com/190/150/cats/3/', author: {
            id: 1,
            name: 'osamu dazai'
          }
        },
        { id: 2, name: '羅生門・鼻', imageUrl: 'http://lorempixel.com/190/150/cats/3/', author: {
            id: 1,
            name: 'osamu dazai'
          }
        },
        { id: 3, name: '御伽草子', imageUrl: 'http://lorempixel.com/190/150/cats/3/', author: {
          id: 1,
          name: 'osamu dazai'
        }
        }
      ]

    gets : ->
      return @_books
