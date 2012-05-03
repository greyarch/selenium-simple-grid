net = require 'net'
selenium = require './selenium'
config = require './servers'

exports.mapping = mapping = {}

exports.server = net.createServer (incoming) ->
    clientId = "#{incoming.remoteAddress}:#{incoming.remotePort}" 
    mapping[clientId] = {url: "", server: ""}
    outgoing = selenium.createSession()
    incoming.pipe outgoing
    outgoing.pipe incoming
    
    incoming.on "data", (data) ->
        parse = /cmd=getNewBrowserSession&1.*&2=(.*)&\d/.exec data.toString()
        if parse
            mapping[clientId].url = decodeURIComponent parse[1]
    
    outgoing.on "connect", () ->
        mapping[clientId].server = "#{outgoing.remoteAddress}:#{outgoing.remotePort}"