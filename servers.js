var servers = [
    {"name" : "server1", "host" : "127.0.0.1", "port" : "4444"},
    {"name" : "server2", "host" : "127.0.0.1", "port" : "4445"}
]

var availableServers = servers;
var busyServers = [];

exports.getAvailableServer = function() {
    var server = availableServers.shift();
    busyServers.push(server);
    console.log("Providing server:");
    console.dir(server);
    return server;
}

exports.releaseServer = function(server) {
    console.log("Releasing server:")
    console.dir(server);
    var i = busyServers.indexOf(server);
    availableServers.push(server);
    busyServers.splice(i, 1);
}

exports.getAvailableServers = function() {
    return availableServers;
}

exports.getBusyServers = function() {
    return busyServers;
}