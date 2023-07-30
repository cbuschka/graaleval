FROM ghcr.io/graalvm/native-image:ol8-java17-22.3.3

RUN microdnf -y install findutils
RUN mkdir -p /work
WORKDIR /work
ENTRYPOINT [ "/bin/bash", "-x" ]
