var net = require('net');
var selenium = require('./servers')

function createSeleniumServerSession(server) {
    return seleniumServer = net.createConnection(server.port, server.host, function() {
        console.log("Connecting to server:");
        console.dir(server);
    }).on("data", function(data) {
        console.log(data.toString());
    });
}

exports.server = net.createServer(function(testSocket) {
    var newServer = selenium.getAvailableServer();
    var seleniumSession = createSeleniumServerSession(newServer);
    testSocket.pipe(seleniumSession);
    seleniumSession.pipe(testSocket);
    testSocket.on("close", function() {
        selenium.releaseServer(newServer);
    });
});