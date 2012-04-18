hub = require './hub'
web = require './web'

hub.server.listen 4444
web.server.listen 8888

console.log 'Selenium hub running at 127.0.0.1:4444'
console.log 'Web server running at 127.0.0.1:8888'