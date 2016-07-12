#!/bin/bash

echo "Download and build the system";

# This script should run as an unpriviledged user. when it needs su privileges for dependancies that you
# dont yet have installed, it uses sudo for that line only.
if [ "$(whoami)" == "root" ]
  then {
    echo ""
    echo ""
    echo "Please do NOT run this script as root/sudo."
    echo ""
    echo "This script should run as an unpriviledged user, when it needs su privileges"
    echo "for dependancies that you dont yet have installed, it uses sudo for that line only."
    echo ""
    echo "eg:"
    echo ""
    echo "$ bash "`basename $0`
    echo ""
    exit 1;
  }
fi


#IF you want to customize the home's location, change this variable
AUTH_WORKSHOP_HOME=$HOME/auth_workshop

# For wget on mac using:  "curl -O --retry 999 --retry-max-time 0 -C -"

# We need git to do anything, anyone who is running this script should have git installed
git --version || {
  echo 'You dont have Git installed. We use Git to version the source code, and make it possible for many people to work on the code at the same time. ' ;
  echo 'Please install it, Opening... http://git-scm.com/download/mac';
  echo ''
  echo ''
  sleep 3
  open -a Google\ Chrome http://git-scm.com/download/mac;
  exit 1;
}

# We need node to be able to modify the code, anyone who is running this script should have that too.
node --version || {
  echo 'You dont have Node.js installed yet. We use Node and NPM (Node Package Manager) to install dependancies and make it easier for you to build the code.' ;
  read -p "Do you want me to automatically install Node for you using Homebrew? (using homebrew is the best method to install ndoe on Mac, it makes it so you dont need to use sudo to install global packages." -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
     then {
      brew install node;
      echo "Please review the above log for errors and then re-run this script when you're sure node is ready."
    }
  else {
    echo ''
    echo ''
    echo 'Please install it from the website, Opening... http://nodejs.org';
    sleep 3
    open -a Google\ Chrome http://nodejs.org;
  }
fi
exit 1;
}

which jasmine-node || {
  echo "Installing jasmine-node globally (required to run our test suites) "
  npm install -g git://github.com/kacperus/jasmine-node.git
}
which jshint || {
  echo "Installing jshint globally (required to make sure your code is well-formed) "
  npm install -g jshint
}
which bower || {
  echo "Installing bower globally (required to install client side dependancies for many modules) "
  npm install -g bower
}
which browserify || {
  echo "Installing browserify globally (required to build client side) "
  npm install -g browserify
}

# You might need XCodeif you dont already have it
# gcc --version || { echo 'You dont have a C++ compiler installed, please install it and other developer tools: sudo apt-get build-dep nodejs  or http://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12' ; exit 1; }

echo "Making workshop directory which will house the workshop code, in case you need it"
echo "export AUTH_WORKSHOP_HOME=$AUTH_WORKSHOP_HOME" >> $HOME/.bash_profile

echo "Making DEBUG=* the default on your machine (you can change this after the workshop)"
echo "export NODE_ENV=development" >> $HOME/.bash_profile
echo "export DEBUG=*" >> $HOME/.bash_profile

mkdir $AUTH_WORKSHOP_HOME
cd $AUTH_WORKSHOP_HOME

echo "What is your GitHub username (so we can set that to the origin of the repos instead of the main project)"
echo -n "(e.g. myusernameontgithub) and press [ENTER]: "
read github_username;

echo ''
echo "Downloading the sample authentication architecture from Github."
cd $AUTH_WORKSHOP_HOME
git clone https://github.com/cesine/authenticated-systems-workshop.git
cd authenticated-systems-workshop
echo "Setting the upstream of the repository so that updates are easy to do"
git remote rm upstream
git remote add upstream https://github.com/cesine/authenticated-systems-workshop.git
git remote rm origin
git remote add origin git@github.com:"$github_username"/authenticated-systems-workshop.git;
git stash
git pull upstream master
git stash pop


echo ''
echo "Downloading the sample authentication ui from Github."
cd $AUTH_WORKSHOP_HOME
git clone https://github.com/cesine/as-ui-auth.git
cd as-ui-auth
echo "Setting the upstream of the repository so that updates are easy to do"
git remote rm upstream
git remote add upstream https://github.com/cesine/as-ui-auth.git
git remote rm origin
git remote add origin git@github.com:"$github_username"/as-ui-auth.git;
git stash
git pull upstream master
git stash pop
echo " Installing build dependancies "
npm install
bower install
bower link
echo " Running jshint, tests"
# npm run lint
open SpecRunner.html


echo ''
echo "Downloading the sample authentication service from Github."
cd $AUTH_WORKSHOP_HOME
git clone https://github.com/cesine/as-auth-provider.git
cd as-auth-provider
echo "Setting the upstream of the repository so that updates are easy to do"
git remote rm upstream
git remote add upstream https://github.com/cesine/as-auth-provider.git
git remote rm origin
git remote add origin git@github.com:"$github_username"/as-auth-provider.git;
git stash
git pull upstream master
git stash pop
echo " Installing build dependancies "
npm install
bower install
echo " Running jshint, tests"
# npm run lint
npm test


echo ''
echo "Downloading the sample token repo from Github."
cd $AUTH_WORKSHOP_HOME
git clone https://github.com/cesine/as-token-javascript.git
cd as-token-javascript
echo "Setting the upstream of the repository so that updates are easy to do"
git remote rm upstream
git remote add upstream https://github.com/cesine/as-token-javascript.git
git remote rm origin
git remote add origin git@github.com:"$github_username"/as-token-javascript.git;
git stash
git pull upstream master
git stash pop
echo " Installing build dependancies "
npm install
npm link
bower link
echo " Running jshint, tests"
# npm run browserify
# npm run lint
npm test
open SpecRunner.html


echo ''
echo "Downloading the sample sdk from Github."
cd $AUTH_WORKSHOP_HOME
git clone https://github.com/cesine/as-sdk-javascript.git
cd as-sdk-javascript
echo "Setting the upstream of the repository so that updates are easy to do"
git remote rm upstream
git remote add upstream https://github.com/cesine/as-sdk-javascript.git
git remote rm origin
git remote add origin git@github.com:"$github_username"/as-sdk-javascript.git;
git stash
git pull upstream master
git stash pop
echo " Installing build dependancies "
npm install
npm link
bower link
echo " Running jshint, tests"
# npm run lint
npm test
open SpecRunner.html


echo ''
echo "Downloading the sample manager ui from Github."
cd $AUTH_WORKSHOP_HOME
git clone https://github.com/cesine/as-ui-manager.git
cd as-ui-manager
echo "Setting the upstream of the repository so that updates are easy to do"
git remote rm upstream
git remote add upstream https://github.com/cesine/as-ui-manager.git
git remote rm origin
git remote add origin git@github.com:"$github_username"/PraatTextGridJS.git;
git stash
git pull upstream master
git stash pop
echo " Installing build dependancies "
npm install
bower link
bower link as-sdk-javascript
echo " Running jshint, tests"
# npm run lint
open SpecRunner.html
open index.html


echo " The Manager app is included in the sample architecture"
cd $AUTH_WORKSHOP_HOME
cd authenticated-systems-workshop
cd as-app-manager
echo " Installing build dependancies "
npm install
bower link as-ui-manager
echo " Running jshint, tests"
# npm run lint
npm test

## Running auth service to see if everything downloaded and works ###################################################

echo "Testing if workshop auth service will run"
cd $AUTH_WORKSHOP_HOME/as-auth-provider
bower link as-ui-auth
npm start &
echo "Opening you to the signup page... and the api of /v1/users"
sleep 5
open https://localhost:8010/authentication/signup
open https://localhost:8010/v1/users

echo "Testing if workshop manager server will run"
cd $AUTH_WORKSHOP_HOME/authenticated-systems-workshop/as-app-manager
bower link as-ui-manager
npm start &
echo "Opening you to the manager app"
sleep 5
open http://localhost:8011


echo "You can kill the services using (where xxx is the process id) $ kill xxxx "
ps -au $USER | grep node


