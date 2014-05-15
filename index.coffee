express = require 'express'
bodyParser = require 'body-parser'
methodOverride = require 'method-override'
cookieParser = require 'cookie-parser'
session = require 'express-session'
log4js = require 'log4js'
errorHandler = require 'errorhandler'

log4js.configure 'lib/logConfig.json',reloadSecs: 300

app = module.exports = express()
logger = log4js.getLogger null

#settings
app.set 'port', process.env.PORT || 8088
# map .renderFile to ".html" files
# app.engine('html', require('ejs').renderFile);
# make ".html" the default
# app.set('view engine', 'html');
app.set 'view engine', 'jade'
# app.set('view engine', 'ejs');
#  set views for error and 404 pages
app.set 'views', __dirname + '/views'
# parse request bodies (req.body)
app.use bodyParser()
# support _method (PUT in forms etc)
app.use methodOverride()
app.use cookieParser 'invalid\'s key'
# session support app.use(session({ secret: 'keyboard cat', key: 'sid', cookie: { secure: true }}))
app.use session()
# app.use(express.basicAuth('username', 'password'));
# favicon need require 'serve-favicon'
# app.use favicon __dirname + '/public/favicon.ico'
app.use express.static __dirname + '/public'
# app.use(express.logger('dev'));
app.use log4js.connectLogger logger, level: log4js.levels.INFO , format: ':remote-addr - - "HTTP/:http-version :method :status :content-length :url "  ":referrer" '
app.use (req, res, next) ->
  res.locals.req=req;
  next();

env = process.env.NODE_ENV||'development'
if 'development' == env
  logger.debug 'development model'
  app.use errorHandler()

require('./lib/boot') app, verbose:!module.parent
errorHandler = require './lib/errorHandler'
app.use errorHandler.r5xx
app.use errorHandler.r404

if not module.parent
  app.listen app.get 'port'
  logger.info 'Listening on port ' + app.get 'port'