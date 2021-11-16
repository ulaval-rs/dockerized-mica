# build the dockerfile
docker build -t micabuild -f ./build/Dockerfile .

# run the dockerfile by mounting src/ to /projects/
docker run --name micabuild --mount type=bind,source="$(pwd)"/src,target=/projects micabuild

# copy the project's output to the build/ folder
cp ./src/mica2/mica-dist/target/mica2-*-dist.zip ./build/mica2-*-dist.zip
cp ./src/mica-search-es/target/mica-search-es-*-dist.zip ./build/mica-search-es-*-dist.zip

# delete the container
docker rm micabuild
