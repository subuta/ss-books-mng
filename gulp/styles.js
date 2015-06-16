'use strict';

var gulp = require('gulp');
var sass = require('gulp-ruby-sass');
var paths = gulp.paths;
var $ = require('gulp-load-plugins')();
var bourbon = require('node-bourbon');
var mainBowerFiles = require("main-bower-files");

bourbon.with(paths.src + '/*.scss');

gulp.task('styles', ['pre-styles'], function() {
  var sassOptions = {
    style: 'expanded',
    loadPath: [bourbon.includePaths]
  };

  sass(paths.src + '/app/.tmp/index.scss', sassOptions)
  .pipe(gulp.dest(paths.tmp + '/serve/app/'));
});

gulp.task('pre-styles', function () {
  // task to import app/components's scss files
  var injectFiles = gulp.src([
    paths.src + '/{app,components}/**/*.scss',
    '!' + paths.src + '/app/index.scss'
  ], { read: false });

  var injectOptions = {
    transform: function(filePath) {
      filePath = filePath.replace(paths.src + '/app/', '');
      filePath = filePath.replace(paths.src + '/components/', '../components/');
      return '@import \'../' + filePath + '\';';
    },
    starttag: '// injector',
    endtag: '// endinjector',
    addRootSlash: false
  };

  var indexFilter = $.filter('index.scss');

  return gulp.src([
    paths.src + '/app/index.scss'
  ])
    .pipe(indexFilter)
    .pipe($.inject(injectFiles, injectOptions))
    .pipe(indexFilter.restore())
    .on('error', function handleError(err) {
      console.error(err.toString());
      this.emit('end');
    })
    .pipe(gulp.dest(paths.src + '/app/.tmp'));
});
