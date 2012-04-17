var net = require('net');
var util = require('util')
var config = require('./config');

var availableServers = config.servers;
var busyServers = [];

exports.createSession = function(clientId) {
    console.log(clientId);
    var server = getAvailableServer();
    return seleniumServer = net.connect(server.port, server.host, function() {
        busyServers.push(server);
    }).on("data", function(data) {
        console.log("Response:")
        console.log(data.toString());
    }).on("close", function() {
        releaseServer(server);
    });
}

exports.getAvailableServers = function() {
    return availableServers;
}

exports.getBusyServers = function() {
    return busyServers;
}

getAvailableServer = function() {
    return availableServers.shift();
}

releaseServer = function(server) {
    availableServers.push(server);
    busyServers.splice(busyServers.indexOf(server), 1);
}