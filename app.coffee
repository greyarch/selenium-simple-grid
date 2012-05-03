hub = require './hub'
web = require './web'

hub.server.listen 4444, () ->
    console.log "Selenium hub listening on port %d", hub.server.address().port

web.server.listen 8888, () ->
    console.log "Web server listening on port %d in %s mode", web.server.address().port, web.server.settings.env
