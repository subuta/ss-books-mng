# Angularjs Filter Of Client Side Pagination
# from: http://fdietz.github.io/recipes-with-angular-js/common-user-interface-patterns/paginating-through-client-side-data.html

app = angular.module "ssBooksMng"
app.filter('offset', ->
  return (input, start)  ->
    start = if 0 >= start then 0 else start
    start = parseInt(start, 10)
    input.slice(start)
)
