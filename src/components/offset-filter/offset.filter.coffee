# Angularjs Filter Of Client Side Pagination
# from: http://fdietz.github.io/recipes-with-angular-js/common-user-interface-patterns/paginating-through-client-side-data.html

app = angular.module "kaizenBooksMng"
app.filter('offset', ->
  return (input, start)  ->
    # - 1 means page start from 1
    start = parseInt(start - 1, 10)
    input.slice(start)
)
