exports.servers = [
    {"name" : "selenium-slave18", "host" : "10.19.55.173", "port" : "4444"},
    {"name" : "selenium-slave19", "host" : "10.19.55.174", "port" : "4444"},
    {"name" : "selenium-slave20", "host" : "10.19.55.175", "port" : "4444"},
    {"name" : "selenium-slave21", "host" : "10.19.55.176", "port" : "4444"}
]

exports.reverseDns = (host, port) ->
    console.log "Reversing #{host}:#{port}"
    for s in exports.servers
        return s if s.host == host and s.port == port