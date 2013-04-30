var express = require('express'),
    log4js = require('log4js');
log4js.configure('lib/logConfig.json', { reloadSecs: 300 });
var app = module.exports = express()
    ,logger = log4js.getLogger();

// settings
app.configure(function () {

    app.set('port', process.env.PORT || 8088);

    // map .renderFile to ".html" files
    //app.engine('html', require('ejs').renderFile);
    // make ".html" the default
    //app.set('view engine', 'html');
    app.set('view engine', 'jade');
    //app.set('view engine', 'ejs');
    // set views for error and 404 pages
    app.set('views', __dirname + '/views');

    //app.use(express.basicAuth('username', 'password'));
    app.use(express.favicon());
    //app.use(express.logger('dev'));
    app.use(log4js.connectLogger(logger, { level: log4js.levels.INFO , format: ':remote-addr - - "HTTP/:http-version :method :status :content-length :url "  ":referrer" '}));
    // parse request bodies (req.body)
    app.use(express.bodyParser());
    // support _method (PUT in forms etc)
    app.use(express.methodOverride());
    // session support
    app.use(express.cookieParser('invalid\'s key'));
    app.use(express.session());
    //app.use(app.router);
    app.use(express.static(__dirname + '/public'));

    app.use(function(req, res, next){
        res.locals.req=req;
        next();
    });
    // load controllers
    require('./lib/boot')(app, { verbose:!module.parent });
    var errorHandler = require('./lib/errorHandler');
    app.use(errorHandler.r5xx);
    app.use(errorHandler.r404);
});

app.configure('development', function () {
    console.log('development model');
    app.use(express.errorHandler());
});

if (!module.parent) {
    app.listen(app.get('port'));
    logger.info('Listening on port ' + app.get('port'));
}