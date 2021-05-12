#!/bin/sh

echo "Coucou"
cd /site/
rm -Rf public
git clone https://github.com/halogenica/beautifulhugo.git themes/beautifulhugo
hugo 
cd public


git config --global user.email "nicolas.savois@gmail.com"
git config --global user.name "Nicolas SAVOIS"
git init
git remote add origin https://savoisn:${OTHER_GITHUB_TOKEN}@github.com/savoisn/savoisn.github.io.git
git add .
git commit -m "update"
git push origin master --force
