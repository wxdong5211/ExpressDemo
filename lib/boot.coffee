express = require 'express'
fs = require 'fs'

module.exports = (parent, options) ->
  verbose = options.verbose
  home = options.welcome ? 'home'
  mode = options.mode ? 'list'
  basedir = options.basedir ? './../controllers'
  verbose and console.log 'welcome %s', home
  autoRequire parent,home,basedir,'',mode,verbose

autoRequire = (parent,home,basedir,offsetpath,mode,verbose) ->
  dirpath = basedir + offsetpath
  fs.readdirSync(__dirname + dirpath).forEach (name) ->
    verbose and console.log '   %s:',name
    if (name is 'index.js' or name is 'index.coffee') and offsetpath isnt ''
      return
    if mode is 'tree' and fs.statSync(__dirname + dirpath+'/'+name).isDirectory()
      autoRequire parent,home,basedir,offsetpath+'/'+name,mode,verbose
      return
    try
      if ~name.indexOf '.js'
        name = name.split('.js')[0];
      else if ~name.indexOf '.coffee'
        name = name.split('.coffee')[0]
      obj = require dirpath+'/'+ name
    catch e
      verbose and console.log 'autorequire fail %s:', e
    if obj is null or not obj.isController
      return
    name = obj.name ? name
    prefix = obj.prefix ? ''
    app = express()
    verbose and console.log 'obj=', obj
    # allow specifying the view engine
    if obj.engine
      app.set 'view engine', obj.engine
    app.set 'views', __dirname + '/../views/' + name
    # before middleware support
    if obj.before
      path = '/' + name + '/:' + name + '_id'
      app.all path, obj.before
      verbose and console.log '     ALL %s -> before', path
      path = '/' + name + '/:' + name + '_id/*';
      app.all path, obj.before
      verbose and console.log '     ALL %s -> before', path

    # generate routes based
    # on the exported methods
    for key,val of obj
      # "reserved" exports
      if ~['isController', 'name', 'prefix', 'engine', 'before'].indexOf key
        continue
      # route exports
      switch key
        when  'get','post','put','delete', 'head' #,'trace','options','connect'
          path = offsetpath + '/' + name
        else
          throw new Error 'unrecognized route: ' + name + '.' + key
      path = prefix + path
      app[key] path, val
      if home is name
        app['get'] '/', val
      verbose and console.log '     %s %s -> %s', key.toUpperCase(), path, key
    # mount the app
    parent.use app