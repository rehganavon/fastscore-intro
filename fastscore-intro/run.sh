#!/bin/bash
echo "Bringing up FastScore containers..."
docker-compose up -d
sleep 5 # wait for things to get set up

echo "Connecting to Dashboard and Configuring FastScore..."
fastscore connect https://host01:80
fastscore config set config.yml
sleep 5

echo "Adding Models to FastScore..."

fastscore model add gbm_python ./models/python_gbm.py

fastscore attachment upload gbm_python ./attachments/attachment.tar.gz

fastscore stream add file_in ./streams/file_input.json
fastscore stream add file_out ./streams/file_output.json

fastscore stream add rest ./streams/rest.json

fastscore stream add kafka_in ./streams/kafka_input.json
fastscore stream add kafka_out ./streams/kafka_output.json

fastscore schema add gbm_input ./schemas/gbm_input.avsc
fastscore schema add gbm_output ./schemas/gbm_output.avsc

STR="Done"

exit 0

