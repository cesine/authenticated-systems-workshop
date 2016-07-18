var fs = require('fs');

var config = {
  client_id: process.env.AS_CLIENT_ID || '--insert-your-client-id-here--',
  client_secret: process.env.AS_CLIENT_SECRET || '--insert-your-client-secret-here--',
  url: 'https://localhost:8011',
  ssl: {
    key: fs.readFileSync(__dirname + '/ssl_debug.key', 'utf8'),
    cert: fs.readFileSync(__dirname + '/ssl_debug.crt', 'utf8')
  }
};

module.exports = config;
