net = require 'net'
util = require 'util'
config = require './config'

availableServers = config.servers
busyServers = []

exports.createSession = (clientEndpoint) ->
    console.log clientEndpoint
    server = getAvailableServer()
    seleniumServer = net.connect server.port, server.host, () ->
        busyServers.push server
    .on "data", (data) ->
        console.log "Response: #{data.toString()}"
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