#!/bin/sh
TAG_FILE=/etc/insights-client/tags.yaml
if [ ! -e $TAG FILE ]; then echo '---' > $TAG_FILE; fi
TOKEN=`curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` && TAGS=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/tags/instance`
sed -i '/^aws\/.*:/d' $TAG_FILE
for TAG in $TAGS
do
  VALUE=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/tags/instance/$TAG`
  echo aws/$TAG: $VALUE >> $TAG_FILE
done
