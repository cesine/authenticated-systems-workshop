'use strict';

var bodyParser = require('body-parser');
var debug = require('debug')('app');
var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var morgan = require('morgan');

var errorsMiddleware = require('./middleware/error');

var app = express();

var env = process.env.NODE_ENV || 'development';
app.locals.ENV_DEVELOPMENT = env === 'development';

/**
 * Config
 */
app.use(morgan('combined'));

/**
 * Body parsers
 */
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
  extended: true
}));

/**
 * Authentication
 */

/**
 * Serve static files
 */

app.use(favicon(__dirname + '/public/favicon.ico'));

app.use(express.static(path.join(__dirname, 'public/components/as-ui-manager')));

/**
 * Routes
 */

// app.use('/', function(req, res, next) {
//   res.send('TODO: include the ui');
// });


/**
 * If not found
 */
app.use(function(req, res, next) {
  debug(req.url + ' was not found');
  var err = new Error('Not Found');
  err.status = 404;
  next(err, req, res, next);
});

/**
 * Attach error handler
 */
app.use(errorsMiddleware);

module.exports = app;
