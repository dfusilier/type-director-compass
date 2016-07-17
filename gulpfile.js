var gulp = require('gulp');
var exec = require('child_process').exec;

var paths = {
  extension: ['stylesheets/**', 'lib/**'],
  templates: ['templates/**', '!templates/project/stylesheets/**']
};

gulp.task('delete-gem-files', function (cb) {
	exec('rm sane-scale-*.gem', function (err, stdout, stderr) {
    console.log(stdout);
    console.log(stderr);
    // Will throw error if files doens't exist. 
    // That's ok. Callback anyway.
    cb();
  });
});

gulp.task('cleanup-gem-versions', ['delete-gem-files'], function (cb) {
  exec('gem cleanup sane-scale', function (err, stdout, stderr) {
    console.log(stdout);
    console.log(stderr);
    cb(err);
  });
});

gulp.task('uninstall-gem', ['cleanup-gem-versions'], function (cb) {
  exec('gem uninstall sane-scale', function (err, stdout, stderr) {
    console.log(stdout);
    console.log(stderr);
    cb(err);
  });
});

gulp.task('build-gem', ['uninstall-gem'], function (cb) {
  exec('gem build sane-scale.gemspec', function (err, stdout, stderr) {
    console.log(stdout);
    console.log(stderr);
    cb(err);
  });
})

gulp.task('install-gem', ['build-gem'], function (cb) {
  exec('gem install sane-scale-*.gem', function (err, stdout, stderr) {
    console.log(stdout);
    console.log(stderr);
    cb(err);
  });
})

gulp.task('compass-compile', ['install-gem'], function (cb) {
  exec('compass compile templates/project', function (err, stdout, stderr) {
    console.log(stdout);
    console.log(stderr);
    cb(err);
  });
})

gulp.task('rebuild-extension', ['compass-compile']);


// Watch for changes to extension, template and rebuild gem.
// Also use compass to watch template.
gulp.task('watch', ['rebuild-extension'], function (cb) {
  gulp.watch(paths.extension, ['rebuild-extension']);
  gulp.watch(paths.templates, ['rebuild-extension']);
});


// The default task (called when you run `gulp` from cli)
gulp.task('default', ['watch']);