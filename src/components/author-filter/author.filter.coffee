# Angularjs Filter Of Client Side Pagination
# from: http://fdietz.github.io/recipes-with-angular-js/common-user-interface-patterns/paginating-through-client-side-data.html

app = angular.module "kaizenBooksMng"
app.filter('author', (_) ->
  return (input, authors, authorName)  ->
    # 著者名が空欄でなかったら
    unless _.isEmpty(authorName)
      # 名前から著者を探す(複数Hitの場合は最初のやつ)
      author = _.find(authors, (author) ->
        return author.name.indexOf(authorName) != -1
      )
      # 著者が見つかったら、該当の著者の作品のみを返却する。
      if author
        return _.where(input, { author_id: Number(author.id) })
      else
        # 著者が見つからなかったら、空で返す。
        return []
    return input
)
