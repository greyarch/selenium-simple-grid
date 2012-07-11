net = require 'net'
selenium = require './selenium'
config = require './servers'

exports.mapping = mapping = {}

exports.server = net.createServer (incoming) ->
    incoming.on "connect", () ->
        clientId = "#{incoming.remoteAddress}:#{incoming.remotePort}" 
        mapping[clientId] = {url: "", server: ""}
        outgoing = selenium.createSession()
        
        incoming.pipe outgoing
        outgoing.pipe incoming

        outgoing.on "connect", () ->
            mapping["#{incoming.remoteAddress}:#{incoming.remotePort}"].server = "#{outgoing.remoteAddress}:#{outgoing.remotePort}"            
        
        outgoing.on "close", () ->
            incoming.end()

    incoming.on "data", (data) ->
        clientId = "#{incoming.remoteAddress}:#{incoming.remotePort}" 
        request = data.toString()
        selenium1 = /cmd=getNewBrowserSession&1.*&2=(.*)&\d/.exec request
        selenium2 = /POST \/wd\/hub\/session\/(\d.*)\/url/.exec request
        if selenium1
            mapping[clientId].url = decodeURIComponent selenium1[1]
        if selenium2
            console.log "Session id is #{selenium2[1]}"
            url = /{"url":"(.*)"}/.exec request
            mapping[clientId].url = url[1]
            

exports.clearMapping = () ->
    exports.mapping = mapping = {}
