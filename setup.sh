export MICA_BRANCH=master
export MICA_SEARCH_ES_BRANCH=master

# download repository content
mkdir src/
cd src
git clone https://github.com/ulaval-rs/mica2.git
cd mica2
git checkout $MICA_BRANCH

cd ..
git clone https://github.com/obiba/mica-search-es.git
cd mica-search-es
git checkout $MICA_SEARCH_ES_BRANCH
cd ..
cd ..
