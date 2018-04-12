#!/bin/bash
docker-compose -f kafka-compose.yml up -d
docker-compose up -d
sleep 15 # wait for things to get set up

fastscore connect https://host01:80
fastscore config set config.yml
sleep 5

docker-compose exec engine-1 pip install scikit-learn==0.18.1
docker-compose exec engine-1 pip install pandas==0.19.0

fastscore model add gbm_python ./models/python_gbm.py

fastscore attachment upload gbm_python ./attachments/attachment.tar.gz

fastscore stream add file_in ./streams/file_input.json
fastscore stream add file_out ./streams/file_output.json

fastscore stream add rest ./streams/rest.json

fastscore stream add kafka_in ./streams/kafka_input.json
fastscore stream add kafka_out ./streams/kafka_output.json

fastscore schema add gbm_input ./schemas/gbm_input.avsc
fastscore schema add gbm_output ./schemas/gbm_output.avsc

exit 0

