jade = require 'jade'
http = require 'http'
selenium = require './selenium'
hub = require './hub'
util = require 'util'

exports.server = http.createServer (req, res) ->
    data = selenium.getServers()
    data.mappings = hub.mapping
    console.log "Mapping is #{util.inspect(data.mappings)}"
    jade.renderFile 'web.jade', data, (err, html) ->
        if html
            res.end html
        else
            res.end "ERROR: " + err