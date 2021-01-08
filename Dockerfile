FROM adoptopenjdk/openjdk8:centos
LABEL maintainer "sprheany@gmail.com"

USER root

ARG SDK_TOOL_URL="https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip"
ENV ANDROID_HOME="/usr/local/android-sdk-linux"

RUN yum install -y unzip python3 && \
    mkdir -p $ANDROID_HOME && \
    cd $ANDROID_HOME && \
    curl -o sdk.zip $SDK_TOOL_URL && \
    unzip sdk.zip && \
    rm sdk.zip

RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager --sdk_root=$ANDROID_HOME "cmdline-tools;latest" && \
    yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --licenses && \
    $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "platform-tools" && \
    touch ~/.android/repositories.cfg

ENV PATH $ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH