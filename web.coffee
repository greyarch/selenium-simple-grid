express = require 'express'
routes = require './routes'
           
exports.server = webapp = express.createServer()

# Configuration

webapp.configure () -> 
    webapp.set('views', __dirname + '/views');
    webapp.set('view engine', 'jade');
    webapp.use(express.bodyParser());
    webapp.use(express.methodOverride());
    webapp.use(webapp.router);
    webapp.use(express.static(__dirname + '/public'));

webapp.configure 'development', () ->
    webapp.use express.errorHandler({ dumpExceptions: true, showStack: true })

webapp.configure 'production', () ->
    webapp.use(express.errorHandler());

# Routes

webapp.get '/', routes.index
webapp.get '/offline/:index', routes.offline
webapp.get '/online/:index', routes.online
webapp.get '/drop/:index', routes.drop
webapp.post '/add', routes.add