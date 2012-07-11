exports.servers = servers = [
    {"name" : "selenium-slave13", "host" : "10.19.55.86", "port" : "4444"},
    {"name" : "selenium-slave14", "host" : "10.19.55.87", "port" : "4444"},
    {"name" : "selenium-slave16", "host" : "10.19.55.90", "port" : "4444"},
    {"name" : "selenium-slave17", "host" : "10.19.55.172", "port" : "4444"},
    {"name" : "selenium-slave18", "host" : "10.19.55.173", "port" : "4444"},
    {"name" : "selenium-slave19", "host" : "10.19.55.174", "port" : "4444"},
    {"name" : "selenium-slave20", "host" : "10.19.55.175", "port" : "4444"},
    {"name" : "selenium-slave21", "host" : "10.19.55.176", "port" : "4444"}
]

exports.reverseDns = (host, port) ->
    console.log "Reversing #{host}:#{port}"
    for s in servers
        return s if s.host == host and s.port == port
        
Array::pull = (index) ->
    result = @[index]
    @.splice index, 1
    return result