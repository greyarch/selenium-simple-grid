var jade = require('jade')
var http = require('http')

var selenium = require('./servers')

exports.server = http.createServer(function(req, res) {
    jade.renderFile('web.jade', {
        availableServers: selenium.getAvailableServers(),
        busyServers: selenium.getBusyServers()
    }, function(err, html) {
        if (html) {
            res.end(html);
        } else {
            res.end("ERROR: " + err);
        }
    });
})