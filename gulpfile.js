var gulp = require('gulp');
var coffee = require('gulp-coffee');
var sourcemaps = require('gulp-sourcemaps');
var uglify = require('gulp-uglify');
var concat = require('gulp-concat');
var del = require('del');

var paths = {
    scripts: ['public/js/**/*.coffee', '!public/js/external/**/*.coffee'],
    images: 'public/img/**/*'
};

gulp.task('clean', function(cb) {
    del(['logs/**/*'],cb);
});

gulp.task('scripts', ['clean'], function() {
    // Minify and copy all JavaScript (except vendor scripts)
    // with sourcemaps all the way down
    return gulp.src(paths.scripts)
        .pipe(sourcemaps.init())
        .pipe(coffee())
        .pipe(uglify())
        .pipe(concat('all.min.js'))
        .pipe(sourcemaps.write())
        .pipe(gulp.dest('public/js'));
});

gulp.task('watch',function(){
    gulp.watch(paths.scripts,['scripts'])
});

gulp.task('default', ['scripts']);