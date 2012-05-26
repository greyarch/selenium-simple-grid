selenium = require '../selenium'
hub = require '../hub'
util = require 'util'

exports.index = (req, res) ->
    data = selenium.getServers()
    res.render 'index', data
    
exports.offline = (req, res) ->
    selenium.takeOffline req.params.index
    res.redirect "/"
    
exports.online = (req, res) ->
    selenium.putOnline req.params.index
    res.redirect "/"

exports.drop = (req, res) ->
    selenium.dropServer req.params.index
    res.redirect "/"

exports.add = (req, res) ->
    selenium.addServer req.body.server
    res.redirect "/"
    
exports.log = (req, res) ->
    res.render 'log', {mappings: hub.mapping}

exports.clearLog = (req, res) ->
    hub.clearMapping()
    res.redirect "/log"