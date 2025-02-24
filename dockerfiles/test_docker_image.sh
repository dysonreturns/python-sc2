# This script is meant for development, which produces fresh images and then runs tests
# Run via
# sh dockerfiles/test_docker_image.sh

# Stop on error https://stackoverflow.com/a/2871034/10882657
set -e

# Set which versions to use
export VERSION_NUMBER=${VERSION_NUMBER:-0.9.9}
export PYTHON_VERSION=${PYTHON_VERSION:-3.12}
export SC2_VERSION=${SC2_VERSION:-4.10}

# For better readability, set local variables
IMAGE_NAME=burnysc2/python-sc2-docker:py_$PYTHON_VERSION-sc2_$SC2_VERSION-v$VERSION_NUMBER
BUILD_ARGS="--build-arg PYTHON_VERSION=$PYTHON_VERSION --build-arg SC2_VERSION=$SC2_VERSION"

# Allow image squashing by enabling experimental docker features
# https://stackoverflow.com/a/21164441/10882657
# https://github.com/actions/virtual-environments/issues/368#issuecomment-582387669
# file=/etc/docker/daemon.json
# if [ ! -e "$file" ]; then
#   echo $'{\n    "experimental": true\n}' | sudo tee /etc/docker/daemon.json
#   sudo systemctl restart docker.service
# fi

# Build image without context
# https://stackoverflow.com/a/54666214/10882657
docker build -t $IMAGE_NAME $BUILD_ARGS - < dockerfiles/Dockerfile
# Build squashed image where the layers are combined to one
#docker build -t $IMAGE_NAME-squashed --squash $BUILD_ARGS - < dockerfiles/Dockerfile

# Delete previous container if it exists
docker rm -f test_container

# Start container, override the default entrypoint
docker run -i -d \
  --name test_container \
  --env 'PYTHONPATH=/root/python-sc2' \
  --entrypoint /bin/bash \
  $IMAGE_NAME

# Install requirements
docker exec -i test_container mkdir -p /root/python-sc2
docker cp pyproject.toml test_container:/root/python-sc2/
docker cp uv.lock test_container:/root/python-sc2/
docker exec -i test_container bash -c "pip install uv && cd python-sc2 && uv sync --no-cache --no-install-project"

docker cp sc2 test_container:/root/python-sc2/sc2
docker cp test test_container:/root/python-sc2/test

# Run various test bots
docker exec -i test_container bash -c "cd python-sc2 && uv run python test/travis_test_script.py test/autotest_bot.py"
docker exec -i test_container bash -c "cd python-sc2 && uv run python test/travis_test_script.py test/queries_test_bot.py"
#docker exec -i test_container bash -c "cd python-sc2 && uv run python test/travis_test_script.py test/damagetest_bot.py"

docker cp examples test_container:/root/python-sc2/examples
docker exec -i test_container bash -c "cd python-sc2 && uv run python test/run_example_bots_vs_computer.py"

# Command for entering the container to debug if something went wrong:
# docker exec -it test_container bash
