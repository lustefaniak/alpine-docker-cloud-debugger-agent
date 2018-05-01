FROM anapsix/alpine-java:8u144b01_jdk_unlimited

RUN apk --no-cache add bash git curl gcc g++ make cmake python maven openjdk8
RUN git clone https://github.com/GoogleCloudPlatform/cloud-debug-java

WORKDIR cloud-debug-java
RUN bash build.sh
RUN mkdir -p /opt/cdbg
RUN tar -xvf cdbg_java_agent_service_account.tar.gz -C /opt/cdbg

FROM anapsix/alpine-java:8u144b01_jdk_unlimited

RUN apk --no-cache add openjdk8-jre
COPY --from=0 /opt/cdbg /opt/cdbg
