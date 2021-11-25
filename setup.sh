export MICA_BRANCH=mica-4.5.x
export MICA_SEARCH_ES_BRANCH=master

# download repository content
mkdir src/
cd src
git clone https://github.com/obiba/mica2.git
cd mica2
git checkout $MICA_BRANCH

cd ..
git clone https://github.com/obiba/mica-search-es.git
cd mica-search-es
git checkout $MICA_SEARCH_ES_BRANCH
cd ..
cd ..
