# as-app-manager
Authenticated Systems Workshop - Sample Node.js App which displays HTML5 client side app

This is an app that simply serves the `as-ui-manager` client side interface.

```
 as-app-manager
 ├── app.js
 ├── config.js
 ├── package.json
 ├── public
 │   └── components
 │       └── as-ui-manager
 │           ├── bower_components
 │           │   └── as-sdk-javascript
 │           └── index.html
 └── test
     ├── app.js
     ├── config.js
     └── integration
     └── app.js
```

## Install

`npm install`

This fetches the client side from its own repo.

`bower install`

## Run

This turns on the server and begins serving the static content of the as-ui-manager project.

`npm start`


## Test

This runs the tests for the server to be sure its dependancies have been downloaded and are ready to use.

`npm test`


## Test Coverage

`npm run coverage`

View Coverage report

`open coverage/lcov-report/index.html`
