#!/usr/bin/env sh

# abort on errors
set -e

# build
npm run build -- --mode=prerender

# saves the lang dirs safely
mkdir lang
mv dist/en lang/en
mv dist/fr lang/fr
mv dist/de lang/de

# builds again
npm run build

# moves the lang files back
mv lang/en dist/en
mv lang/fr dist/fr
mv lang/de dist/de

rm -r lang

# Finds the name of app.js
FILEAPPNAME=$(ls dist/js | grep 'app\..*\.js$')

# Replaces app.js in the files
sed -i "s/\/app\.js/\/germanness\/js\/$FILEAPPNAME/g" dist/de/index.html
sed -i "s/\/app\.js/\/germanness\/js\/$FILEAPPNAME/g" dist/fr/index.html
sed -i "s/\/app\.js/\/germanness\/js\/$FILEAPPNAME/g" dist/en/index.html

# Same thing for vendors-chunck
FILEAPPNAME=$(ls dist/js | grep 'chunk.*\.js$')
sed -i "s/<script/<script src=\"\/germanness\/js\/$FILEAPPNAME\"><\/script><script/g" dist/de/index.html
sed -i "s/<script/<script src=\"\/germanness\/js\/$FILEAPPNAME\"><\/script><script/g" dist/fr/index.html
sed -i "s/<script/<script src=\"\/germanness\/js\/$FILEAPPNAME\"><\/script><script/g" dist/en/index.html

# rename dist dir
rm -r docs
mv dist docs

# Sends to Github
git ac -m "Updates"

git push origin master