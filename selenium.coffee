net = require 'net'
util = require 'util'
config = require './config'

availableServers = config.servers
busyServers = []

exports.createSession = (clientEndpoint) ->
  console.log clientEndpoint
  server = getAvailableServer()
  return seleniumServer = net.connect server.port, server.host, () ->
    busyServers.push server
  .on "data", (data) ->
    console.log "Response:"
    console.log data.toString()
  .on "close", () ->
    releaseServer server

exports.getServers = () -> 
  availableServers: selenium.getAvailableServers(),
  busyServers: selenium.getBusyServers()

getAvailableServer = () ->
  return availableServers.shift()

releaseServer = (server) ->
  availableServers.push server
  busyServers.splice busyServers.indexOf(server), 1