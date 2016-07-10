'use strict';

var debug = require('debug')('middleware:error');

/*jshint -W098 */
function errors(err, req, res, next) {
  /*jshint +W098 */
  var data;

  debug(err.stack);

  if (process.env.NODE_ENV === 'development') {
    // expose stack traces
    data = {
      message: err.message,
      error: err
    };
  } else {
    // production error handler
    data = {
      message: err.message,
      error: {}
    };
  }

  data.status = err.status || err.statusCode || 500;

  if (data.status === 500 && data.message === 'Failed to obtain access token') {
    data.status = 403;
  }

  res.status(data.status);
  res.json(data);
}

module.exports = errors;
