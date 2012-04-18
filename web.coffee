jade = require 'jade'
http = require 'http'
selenium = require './selenium'

exports.server = http.createServer (req, res) ->
  jade.renderFile 'web.jade', selenium.getServers(), (err, html) ->
    if html
      res.end html
    else
      res.end "ERROR: " + err