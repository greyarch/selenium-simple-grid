var hub = require('./hub');
var web = require('./web');

hub.server.listen(1337);
web.server.listen(8888);

console.log('Selenium hub running at 127.0.0.1:1337');
console.log('Web server running at 127.0.0.1:8888');