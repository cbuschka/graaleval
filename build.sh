#!/bin/bash

trap "exit 1" SIGINT
trap "exit 1" SIGTERM
trap "exit 1" SIGHUP

WORK_DIR=$(cd `dirname 0` && pwd)

rm -rf $WORK_DIR/target && mkdir -p $WORK_DIR/target/classes
cd $WORK_DIR/src
javac -d $WORK_DIR/target/classes/ $(find . -name '*.java')
cd $WORK_DIR/target/classes
mkdir -p $WORK_DIR/target/classes
cat - >$WORK_DIR/target/manifest.mf <<EOB
Main-Class: graaleval.Main
EOB
jar cvfm $WORK_DIR/target/app.jar $WORK_DIR/target/manifest.mf .
jar tvf $WORK_DIR/target/app.jar
cd $WORK_DIR/target
native-image --enable-url-protocols=http \
                      -Djava.net.preferIPv4Stack=true \
                      -H:+ReportUnsupportedElementsAtRuntime --no-server -jar $WORK_DIR/target/app.jar

#                      -H:ReflectionConfigurationFiles=$WORK_DIR/reflect.json \


