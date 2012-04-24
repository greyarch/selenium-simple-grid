net = require 'net'
util = require 'util'
config = require './config'

availableServers = config.servers
busyServers = []
mappings = []

exports.createSession = () ->
    server = getAvailableServer()
    seleniumServer = net.connect server.port, server.host, () ->
        busyServers.push server
    .on "close", () ->
        releaseServer server

exports.getServers = () -> 
    availableServers: availableServers,
    busyServers: busyServers

getAvailableServer = () ->
    availableServers.shift()

releaseServer = (server) ->
    availableServers.push server
    busyServers.splice busyServers.indexOf(server), 1