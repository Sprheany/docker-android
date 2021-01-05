FROM centos:7
LABEL maintainer "sprheany@gmail.com"

USER root

RUN yum install -y unzip python3

# install java8

ARG JDK_VERSION="1.8.0.275.b01-0.el7_9.x86_64"
ENV JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk-$JDK_VERSION"

RUN yum install -y java-1.8.0-openjdk-devel-$JDK_VERSION

ENV PATH $JAVA_HOME/bin:$PATH

# install android sdk

ARG SDK_TOOL_URL="https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip"
ENV ANDROID_HOME="/usr/local/android-sdk-linux"

RUN mkdir -p $ANDROID_HOME && \
    cd $ANDROID_HOME && \
    curl -o sdk.zip $SDK_TOOL_URL && \
    unzip sdk.zip && \
    rm sdk.zip

RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager --sdk_root=$ANDROID_HOME "cmdline-tools;latest" && \
    yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --licenses && \
    $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "platform-tools" && \
    touch ~/.android/repositories.cfg

ENV PATH $ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH