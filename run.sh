#!/bin/bash

# abort the script if there is a non-zero error
set -e

# configure the user
git config --global user.email "$GH_EMAIL" > /dev/null 2>&1
git config --global user.name "$GH_NAME" > /dev/null 2>&1

# clone the repo
git clone $CIRCLE_REPOSITORY_URL repo
cd repo

# checkout the source branch
git checkout $SOURCE_BRANCH

# initialize submodules if any
git submodule update --init

# clean 
rm -rf public

# fresh build
hugo
if [ ! -f CNAME ]; then
     cp CNAME public/CNAME
fi

# copy over the changes to your target branch
cd ..
git clone $CIRCLE_REPOSITORY_URL target
cd target 

# switch to the target branch
git checkout $TARGET_BRANCH
cd ..

# copy over the files
yes | rm -rf target/*
cp -rf ./repo/.circleci ./target/.circleci
cp -rf ./repo/public/* ./target

# commit and push the changes
cd target
git add .
git commit -m "Automated deployment: $(date)"
git push origin $TARGET_BRANCH
 




