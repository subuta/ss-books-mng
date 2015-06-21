app = angular.module "kaizenBooksMng"

# add Waves as Angular's Module
app.constant('Waves', Waves)

# add underscorejs
app.constant('_', _)

# angular moment setting
app.constant('angularMomentConfig',
  preprocess: 'unix', # optional
  timezone: 'Asia/Tokyo' # optional
)
