#!/bin/bash

echo "Test the system has built";
#!/bin/bash

AUTH_WORKSHOP_HOME=$HOME/auth_workshop

echo ''
echo "Downloading the sample authentication ui from Github."
cd $AUTH_WORKSHOP_HOME
cd as-ui-auth
open SpecRunner.html


echo ''
echo "Downloading the sample authentication service from Github."
cd $AUTH_WORKSHOP_HOME
cd as-auth-provider
npm test


echo ''
echo "Downloading the sample token repo from Github."
cd $AUTH_WORKSHOP_HOME
cd as-token-javascript
npm test
open SpecRunner.html


echo ''
echo "Downloading the sample sdk from Github."
cd $AUTH_WORKSHOP_HOME
cd as-sdk-javascript
npm test
open SpecRunner.html


echo ''
echo "Downloading the sample manager ui from Github."
cd $AUTH_WORKSHOP_HOME
cd as-ui-manager
open SpecRunner.html
open index.html


echo " The Manager app is included in the sample architecture"
cd $AUTH_WORKSHOP_HOME
cd authenticated-systems-workshop
cd as-app-manager
npm test
