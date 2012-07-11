net = require 'net'
util = require 'util'
config = require './servers'

availableServers = config.servers
busyServers = []
offlineServers = []

exports.createSession = () ->
    server = getAvailableServer()
    seleniumServer = net.connect server.port, server.host, () ->
        busyServers.push server
    .on "close", () ->
        releaseServer server
    .on "error", () ->
        server.bad = true
        console.log "ERROR: Server #{server.name} will be taken offline. Does not respond to connection requests."
        seleniumServer.close

exports.getServers = () -> 
    availableServers: availableServers,
    busyServers: busyServers,
    offlineServers: offlineServers

exports.takeOffline = (index) ->
    offlineServers.push availableServers.pull(index)
        
exports.putOnline = (index) ->
    srv = offlineServers.pull index
    srv.bad = false
    availableServers.push srv
    
exports.dropServer = (index) ->
    offlineServers.pull(index)
    
exports.addServer = (server) ->
    availableServers.push server
    
getAvailableServer = () ->
    availableServers.shift()

releaseServer = (server) ->
    if server.bad
        offlineServers.push server
    else
        availableServers.push server
        busyServers.splice busyServers.indexOf(server), 1