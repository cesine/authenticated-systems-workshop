'use strict';

var expect = require('chai').expect;
var supertest = require('supertest');

var app = require('./../../');

describe('/v1', function() {
  it('should load', function() {
    expect(app).to.be.a('function');
  });

  describe('is production ready', function() {
    it('should show an error page', function(done) {
      process.env.NODE_ENV = 'production';

      supertest(app)
        .get('/notexistant/page')
        .expect('Content-Type', 'application/json; charset=utf-8')
        .expect(404)
        .end(function(err, res) {
          if (err) throw err;

          expect(res.text).to.contain('Not Found');

          done();
        });
    });

    it('should reply with the index', function(done) {
      process.env.NODE_ENV = 'development';

      supertest(app)
        .get('/')
        .expect('Content-Type', 'text/html; charset=UTF-8')
        .expect(200)
        .end(function(err, res) {
          if (err) throw err;

          // If this fails, run 'bower install' on the project
          expect(res.text).to.contain('TODO: include the ui');

          done();
        });
    });
  });
});
