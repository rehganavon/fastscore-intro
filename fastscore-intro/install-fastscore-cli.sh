#!/bin/bash
if [ -z "$1" ]; then
    echo "No VERSION supplied."
    echo "Usage: $0 <version>"
    exit 1
fi


VERSION=$1
curl https://s3-us-west-1.amazonaws.com/fastscore-cli/fastscore-cli-$VERSION.tar.gz > /tmp/fastscore-cli-$VERSION.tar.gz
tar xzf /tmp/fastscore-cli-$VERSION.tar.gz -C /tmp
pushd /tmp/fastscore-cli-$VERSION
if ! python setup.py install; then
    echo "FastScore CLI setup failed"
    popd
    rm -rf /tmp/fastscore-cli-$VERSION*
    exit 1
fi
popd
rm -rf /tmp/fastscore-cli-$VERSION*
