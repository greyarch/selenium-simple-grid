net = require 'net'
util = require 'util'
config = require './servers'

availableServers = config.servers
busyServers = []
offlineServers = []
mappings = []

exports.createSession = () ->
    server = getAvailableServer()
    seleniumServer = net.connect server.port, server.host, () ->
        busyServers.push server
    .on "close", () ->
        releaseServer server

exports.getServers = () -> 
    availableServers: availableServers,
    busyServers: busyServers,
    offlineServers: offlineServers

exports.takeOffline = (index) ->
    offlineServers.push availableServers.pull(index)

exports.putOnline = (index) ->
    availableServers.push offlineServers.pull(index)
    
exports.dropServer = (index) ->
    offlineServers.pull(index)
    
exports.addServer = (server) ->
    availableServers.push server
    
popServer = (servers, index) ->
    server = servers[index]
    servers.splice index, 1
    return server
    
getAvailableServer = () ->
    availableServers.shift()

releaseServer = (server) ->
    availableServers.push server
    busyServers.splice busyServers.indexOf(server), 1