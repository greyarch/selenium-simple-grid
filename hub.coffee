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
        request = data.toString()
        selenium1 = /cmd=getNewBrowserSession&1.*&2=(.*)&\d/.exec request
        selenium2 = /POST \/wd\/hub\/session\/(\d.*)\/url/.exec request
        if selenium1
            mapping[clientId].url = decodeURIComponent selenium1[1]
        if selenium2
            console.log "Session id is #{selenium2[1]}"
            url = /{"url":"(.*)"}/.exec request
            mapping[clientId].url = url[1]
            
    outgoing.on "connect", () ->
        mapping[clientId].server = "#{outgoing.remoteAddress}:#{outgoing.remotePort}"

exports.clearMapping = () ->
    exports.mapping = mapping = {}
