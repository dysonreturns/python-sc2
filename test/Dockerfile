# Buildable via command from root folder
# docker build -t test_image -f test/Dockerfile --build-arg PYTHON_VERSION=3.10 --build-arg SC2_VERSION=4.10 .

# For more info see https://github.com/BurnySc2/python-sc2-docker
ARG PYTHON_VERSION=3.10
ARG SC2_VERSION=4.10
ARG VERSION_NUMBER=1.0.0

FROM burnysc2/python-sc2-docker:py_$PYTHON_VERSION-sc2_$SC2_VERSION-v$VERSION_NUMBER-squashed

# Debugging purposes
RUN echo $PYTHON_VERSION
RUN echo $SC2_VERSION
RUN echo $VERSION_NUMBER

# Copy files from the current commit (the python-sc2 folder) to root
ADD . /root/python-sc2

# Install the python-sc2 library and its requirements (s2clientprotocol etc.) to python
WORKDIR /root/python-sc2
RUN pip install --no-cache-dir uv \
    # This will not include dev dependencies
    && uv export --format requirements-txt --output-file requirements.txt --no-hashes \
    && pip install --no-cache-dir -r requirements.txt

# This will be executed during the container run instead:
# docker run test_image -c "uv run python examples/protoss/cannon_rush.py"

ENTRYPOINT [ "/bin/bash" ]
