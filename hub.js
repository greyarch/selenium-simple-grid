var net = require('net');
var selenium = require('./selenium')

exports.server = net.createServer(function(incoming) {
    var outgoing = selenium.createSession(incoming.remoteAddress + ":" + incoming.remotePort);
    incoming.pipe(outgoing);
    outgoing.pipe(incoming);
    incoming.on("data", function(data) {
        console.log("Request:")
        console.log(data.toString());
    });
});