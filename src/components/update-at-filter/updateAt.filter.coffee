# Angularjs Filter Of Client Side Pagination
# from: http://fdietz.github.io/recipes-with-angular-js/common-user-interface-patterns/paginating-through-client-side-data.html

app = angular.module "kaizenBooksMng"
app.filter('updateAt', (_, moment) ->
  return (input, query)  ->
    if query
      [num, unit] = query.split(" ")
      return _.filter(input, (_input) ->
        return moment().subtract(num, unit).isBefore(moment(_input.updated_at))
      )
    else
      return input
)

# 更新日時のフィルタ用の設定一覧
app.constant('updateAtQueries', [
  {
    query: '1 hours'
    label: '１時間以内'
  },
  {
    query: '1 days'
    label: '１日以内'
  },
  {
    query: '7 days'
    label: '１週間以内'
  },
  {
    query: '1 months'
    label: '１ヶ月以内'
  },
  {
    query: '3 months'
    label: '３ヶ月以内'
  },
  {
    query: '6 months'
    label: '６ヶ月以内'
  },
  {
    query: '1 years'
    label: '１年以内'
  }
])
