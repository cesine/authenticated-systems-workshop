[![Build Status][travis-image]][travis-url]
[![Coverage Status][coverage-image]][coverage-url]

# Workshop for Authenticated Systems

http://www.meetup.com/NY-JavaScript/events/230489581/

[Slides](https://docs.google.com/presentation/d/1oxP6rqcd_vuvtD-Dik3U5MwdRXR4UVkz3xgKAeRmmkk/edit#slide=id.p)

In this hands-on workshop we will go over a few ways you can implement authentication (including offline authentication strategies) and then dive into some code for both a server and a client which you can adapt to suit your own app.

Come with your laptop, and an idea of an app you want to make, or join forces with others to experiment together!

## Set up

Here is a script which will download, build and link the sample system for you.

* [Mac developer download script](https://raw.githubusercontent.com/cesine/authenticated-systems-workshop/master/build.sh)
<pre>
$ cd $HOME/Downloads && curl -O --retry 999 --retry-max-time 0 -C - https://raw.githubusercontent.com/cesine/authenticated-systems-workshop/master/build.sh && bash build.sh
</pre>

Here is a script which will run all the tests for you

* [Mac developer test script](https://raw.githubusercontent.com/cesine/authenticated-systems-workshop/master/test.sh)
<pre>
$ cd $HOME/Downloads && curl -O --retry 999 --retry-max-time 0 -C - https://raw.githubusercontent.com/cesine/authenticated-systems-workshop/master/test.sh && bash test.sh
</pre>


## Topics discussed

* Using External Oauth2 Providers
* Creating your own Oauth2 Provider
  - Local Authentication Stragegy if users dont want to use their existing accounts with another provider
* User Profile database
  - User's profiles from their Oauth providers + internal fields
* API Client database
  - Registered API clients which can interact with the data on behalf of users
* Border
  - AB testing by user
  - AB testing by API client
  - GEO sharding directing requests to closer instances of  services
  - Ratelimiting x requests per hour/day etc
  - Throttling
  - User authorization/de-authorization
  - Activity tracking
* Library for parsing our JWT
  - Used client side or server side to verify that a given JWT
    - Make available its contents to the context
    - Hasn't been modified since it was signed
    - Hasn't expired
* Sample service repo
  - Use JWT Header to verify request
  - Perform CRUD on a x resource, respecting user's roles on that resource
  - Acceptasn any json as the resource (use leveldb to keep things simple, but could be any persistent store)


## Example Architecture

Here is an example system (the "as" system) and various apps and services which might make up the system.

```
├── as-app-android
│   ├── AndroidManifest.xml
│   └── test
├── as-app-chrome
│   ├── config.js
│   ├── manifest.json
│   ├── package.json
│   └── test
│       ├── config.js
│       └── main.js
├── as-app-electron
│   ├── config.js
│   ├── main.js
│   ├── package.json
│   └── test
├── as-app-manager
│   ├── app.js
│   ├── config.js
│   ├── package.json
│   └── test
│       ├── app.js
│       └── config.js
├── as-auth
│   ├── bower.json
│   ├── config
│   │   ├── as.js
│   │   ├── facebook.js
│   │   ├── google.js
│   │   ├── index.js
│   │   └── twitter.js
│   ├── middleware
│   │   ├── authentication.js
│   │   └── authorization.js
│   ├── package.json
│   ├── routes
│   │   ├── authenticate.js
│   │   └── authorize.js
│   ├── service.js
│   └── test
│       ├── config
│       │   ├── as.js
│       │   ├── facebook.js
│       │   ├── google.js
│       │   ├── index.js
│       │   └── twitter.js
│       ├── integration
│       │   ├── authenticate.js
│       │   ├── authorize.js
│       │   ├── deauthorize.js
│       │   └── signup.js
│       ├── middleware
│       │   ├── authentication.js
│       │   └── authorization.js
│       ├── routes
│       │   ├── authenticate.js
│       │   └── authorize.js
│       └── service.js
├── as-border
│   ├── config.js
│   ├── lib
│   │   ├── activity.js
│   │   ├── rate-limit.js
│   │   └── throttle.js
│   ├── middleware
│   │   ├── activity.js
│   │   ├── api-client.js
│   │   ├── authentication.js
│   │   ├── authorization.js
│   │   ├── index.js
│   │   ├── rate-limit.js
│   │   ├── throttle.js
│   │   └── user.js
│   ├── package.json
│   ├── routes.js
│   ├── service.js
│   └── test
│       ├── integration
│       │   ├── delete.js
│       │   ├── get.js
│       │   ├── patch.js
│       │   └── post.js
│       ├── lib
│       │   ├── activity.js
│       │   ├── rate-limit.js
│       │   └── throttle.js
│       ├── middleware
│       │   ├── activity.js
│       │   ├── api-client.js
│       │   ├── authentication.js
│       │   ├── authorization.js
│       │   ├── index.js
│       │   ├── rate-limit.js
│       │   ├── throttle.js
│       │   └── user.js
│       ├── routes.js
│       └── service.js
├── as-sdk-java
│   ├── MANIFEST.MF
│   ├── src
│   │   └── org
│   │       └── as
│   │           ├── Config.java
│   │           ├── anything
│   │           │   └── Anything.js
│   │           └── user
│   │               └── User.js
│   └── test
│       └── org
│           └── as
│               ├── ConfigTest.java
│               ├── anything
│               │   └── AnythingTest.js
│               └── user
│                   └── UserTest.js
├── as-sdk-javascript
│   ├── anything
│   │   ├── README.md
│   │   ├── anything-spec.js
│   │   ├── anything.css
│   │   ├── anything.js
│   │   ├── anythings-spec.js
│   │   ├── anythings.css
│   │   └── anythings.js
│   ├── index.js
│   ├── package.json
│   ├── test
│   └── user
│       ├── README.md
│       ├── user-spec.js
│       ├── user.css
│       ├── user.js
│       ├── users-spec.js
│       ├── users.css
│       └── users.js
├── as-sdk-python
│   └── MANIFEST.in
├── as-service-x
│   ├── config.js
│   ├── middleware.js
│   ├── package.json
│   ├── routes.js
│   ├── service.js
│   └── test
│       ├── config.js
│       ├── middleware.js
│       ├── routes.js
│       └── service.js
├── as-token-java
│   ├── MANIFEST.MF
│   ├── src
│   │   └── org
│   │       └── as
│   │           └── Token.java
│   └── test
│       └── org
│           └── as
│               └── TokenTest.java
├── as-token-javascript
│   ├── bower.json
│   ├── index.js
│   ├── package.json
│   └── test
│       └── index.js
├── as-token-python
│   └── MANIFEST.in
├── as-ui-auth
│   ├── bower.json
│   ├── components
│   │   ├── authorize
│   │   │   ├── authorize.css
│   │   │   ├── authorize.html
│   │   │   ├── authorize.js
│   │   │   ├── deauthorize.css
│   │   │   ├── deauthorize.html
│   │   │   └── deauthorize.js
│   │   ├── login
│   │   │   ├── login.css
│   │   │   ├── login.html
│   │   │   ├── login.js
│   │   │   ├── login_quick.css
│   │   │   ├── login_quick.html
│   │   │   └── login_quick.js
│   │   └── signup
│   │       ├── signup.css
│   │       ├── signup.html
│   │       └── signup.js
│   └── test
│       └── components
│           ├── authorize
│           │   ├── authorize.js
│           │   └── deauthorize.js
│           ├── login
│           │   ├── login.js
│           │   └── login_quick.js
│           └── signup
│               └── signup.js
├── as-ui-complex
│   ├── bower.json
│   ├── components
│   │   ├── anything
│   │   │   ├── anything_complex.html
│   │   │   └── anythings_complex.html
│   │   ├── app
│   │   │   ├── app.css
│   │   │   ├── app.html
│   │   │   └── app.js
│   │   └── user
│   │       ├── user_complex.html
│   │       └── users_complex.html
│   ├── index.html
│   ├── main.js
│   └── test
│       ├── components
│       │   ├── anything
│       │   │   ├── anything_complex.js
│       │   │   └── anythings_complex.js
│       │   ├── app
│       │   │   └── app.js
│       │   └── user
│       │       ├── user_complex.js
│       │       └── users_complex.js
│       └── main.js
├── as-ui-cute
│   ├── bower.json
│   ├── components
│   │   ├── anything
│   │   │   ├── anything_cute.html
│   │   │   └── anythings_cute.html
│   │   ├── app
│   │   │   ├── app.css
│   │   │   ├── app.html
│   │   │   └── app.js
│   │   └── user
│   │       ├── user_cute.html
│   │       └── users_cute.html
│   ├── index.html
│   ├── main.js
│   └── test
│       ├── components
│       │   ├── anything
│       │   │   ├── anything_cute.js
│       │   │   └── anythings_cute.js
│       │   ├── app
│       │   │   └── app.js
│       │   └── user
│       │       ├── user_cute.js
│       │       └── users_cute.js
│       └── main.js
└── as-ui-manager
    ├── bower.json
    ├── components
    │   ├── anything
    │   │   ├── anything_admin.css
    │   │   ├── anything_admin.html
    │   │   ├── anything_admin.js
    │   │   ├── anything_analytics.css
    │   │   ├── anything_analytics.html
    │   │   ├── anything_analytics.js
    │   │   ├── anythings_admin.css
    │   │   ├── anythings_admin.html
    │   │   └── anythings_admin.js
    │   ├── app
    │   │   ├── app.css
    │   │   ├── app.html
    │   │   └── app.js
    │   └── user
    │       ├── user_admin.css
    │       ├── user_admin.html
    │       ├── user_admin.js
    │       ├── users_admin.css
    │       ├── users_admin.html
    │       └── users_admin.js
    ├── index.html
    ├── main.js
    ├── package.json
    └── test
        ├── components
        │   ├── anything
        │   │   ├── anything_admin.js
        │   │   ├── anything_analytics.js
        │   │   └── anythings_admin.js
        │   ├── app
        │   │   └── app.js
        │   └── user
        │       ├── user_admin.js
        │       └── users_admin.js
        └── main.js
```

# References

* https://tools.ietf.org/html/rfc6749
* https://www.digitalocean.com/community/tutorials/an-introduction-to-oauth-2
* https://stormpath.com/blog/build-api-restify-stormpath
* https://www.digitalocean.com/community/tutorials/openssl-essentials-working-with-ssl-certificates-private-keys-and-csrs
* https://github.com/oauthjs
* http://passportjs.org
* http://nginx.org/en/docs/http/load_balancing.html
* https://github.com/auth0/node-jsonwebtoken
* https://jwt.io

[travis-image]: https://travis-ci.org/cesine/authenticated-systems-workshop.svg?branch=master
[travis-url]: https://travis-ci.org/cesine/authenticated-systems-workshop
[coverage-image]: https://coveralls.io/repos/github/cesine/authenticated-systems-workshop/badge.svg?branch=master
[coverage-url]: https://coveralls.io/github/cesine/authenticated-systems-workshop?branch=master
