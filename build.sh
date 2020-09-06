#!/bin/bash

trap "exit 1" SIGINT
trap "exit 1" SIGTERM
trap "exit 1" SIGHUP

cd /work
rm -rf /work/target && mkdir -p /work/target/classes
cd /work/src
javac -d /work/target/classes/ $(find . -name '*.java')
cd /work/target/classes
mkdir -p /work/target/classes
cat - >/work/target/manifest.mf <<EOB
Main-Class: graaleval.Main
EOB
jar cvfm /work/target/app.jar /work/target/manifest.mf .
jar tvf /work/target/app.jar
cd /work/target
native-image --enable-url-protocols=http \
                      -Djava.net.preferIPv4Stack=true \
                      -H:+ReportUnsupportedElementsAtRuntime --no-server -jar /work/target/app.jar

#                      -H:ReflectionConfigurationFiles=/work/reflect.json \


