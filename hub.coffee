net = require 'net'
selenium = require './selenium'

exports.server = net.createServer (incoming) ->
    outgoing = selenium.createSession(incoming.remoteAddress + ":" + incoming.remotePort)
    incoming.pipe outgoing
    outgoing.pipe incoming
    incoming.on "data", (data) ->
        console.log "Request: #{data.toString()}"
