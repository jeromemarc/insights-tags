#!/bin/sh
TAG_FILE=/etc/insights-client/tags.yaml
if [ ! -e $TAG FILE ]; then echo '---' > $TAG_FILE; fi
TAGS=`curl -s -H Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance/compute/tags?api-version=2021-02-01&format=text"`
sed -i '/^azure\/.*:/d' $TAG_FILE
IFS=';'
for tag in $TAGS
do
  echo "azure/$tag" | sed 's/:/: /' >> $TAG_FILE
done
