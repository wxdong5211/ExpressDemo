var express = require('express')
    , fs = require('fs');

module.exports = function (parent, options) {
    var verbose = options.verbose;
    var home = options.welcome || 'home';
    var mode = options.mode || 'list';
    var basedir = options.basedir || './../controllers';
    verbose && console.log('welcome %s', home);
    autoRequire(parent,home,basedir,'',mode,verbose);
};

function autoRequire(parent,home,basedir,offsetpath,mode,verbose) {
    var dirpath = basedir + offsetpath;
    fs.readdirSync(__dirname + dirpath).forEach(function (name) {
        verbose && console.log('   %s:', name);
        if(name == 'index.js' && offsetpath != '')return;
        if(mode == 'tree' && fs.statSync(__dirname + dirpath+'/'+name).isDirectory()){
            autoRequire(parent,home,basedir,offsetpath+'/'+name,mode,verbose);
            return;
        }
        var obj = null;
        try {
            if (~name.indexOf('.js')) var name = name.split('.js')[0];
            obj = require(dirpath +'/'+ name)
        } catch (e) {
            verbose && console.log('autorequire fail %s:', e);
        }

        if (obj == null || !obj.isController)return;

        var name = obj.name || name
            , prefix = obj.prefix || ''
            , app = express()
            , method
            , path;

        verbose && console.log('obj=', obj);
        // allow specifying the view engine
        if (obj.engine) app.set('view engine', obj.engine);
        app.set('views', __dirname + '/../views/' + name);

        // before middleware support
        if (obj.before) {
            path = '/' + name + '/:' + name + '_id';
            app.all(path, obj.before);
            verbose && console.log('     ALL %s -> before', path);
            path = '/' + name + '/:' + name + '_id/*';
            app.all(path, obj.before);
            verbose && console.log('     ALL %s -> before', path);
        }

        // generate routes based
        // on the exported methods
        for (var key in obj) {
            // "reserved" exports
            if (~['isController', 'name', 'prefix', 'engine', 'before'].indexOf(key)) continue;
            // route exports
            switch (key) {
                case 'get':
                case 'post':
                case 'put':
                case 'delete':
                case 'head':
                //case 'trace':
                //case 'options':
                //case 'connect':
                    method = key;
                    path = offsetpath + '/' + name;
                    //path = '/' + name + '/:' + name + '_id';
                    break;
                default:
                    throw new Error('unrecognized route: ' + name + '.' + key);
            }

            path = prefix + path;
            app[method](path, obj[key]);
            if (home == name)
                app['get']('/', obj[key]);
            verbose && console.log('     %s %s -> %s', method.toUpperCase(), path, key);
        }
        // mount the app
        parent.use(app);
    });
}