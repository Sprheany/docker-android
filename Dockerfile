FROM ubuntu:16.04
MAINTAINER Sprheany <sprheany@gmail.com>

ENV VERSION_SDK_TOOLS "25.2.4"
ENV VERSION_GRADLE "2.14.1"
ENV SDK_PACKAGES "build-tools-25.0.2,android-25,platform-tools,extra-android-m2repository,extra-android-support,extra-google-m2repository"

ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV GRADLE_HOME /usr/local/gradle-${VERSION_GRADLE}

ENV PATH $PATH:${ANDROID_HOME}/tools
ENV PATH $PATH:${ANDROID_HOME}/platform-tools
ENV PATH $PATH:${GRADLE_HOME}/bin

# Install dependencies

RUN dpkg --add-architecture i386 && \
    apt-get -qq update && \
    apt-get install -qqy --no-install-recommends \
        lib32z1 \
        lib32ncurses5 \
        libbz2-1.0:i386 \
        lib32stdc++6 \
        openjdk-8-jdk \
        wget \
        unzip \
        expect \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Fix certificates

RUN rm -f /etc/ssl/certs/java/cacerts; \
    /var/lib/dpkg/info/ca-certificates-java.postinst configure

# Install gradle

RUN wget -q https://services.gradle.org/distributions/gradle-${VERSION_GRADLE}-bin.zip -O /gradle.zip
RUN unzip /gradle.zip -d /usr/local && \
    rm -v /gradle.zip

# Install the SDK tools

RUN wget -q https://dl.google.com/android/repository/tools_r${VERSION_SDK_TOOLS}-linux.zip -O /tools.zip
RUN unzip /tools.zip -d /${ANDROID_HOME} && \
    rm -v /tools.zip

# Install our helpers

COPY tools /usr/local/bin/tools
RUN chmod +x /usr/local/bin/tools/agree-to-licenses.sh

# And use them to install Android dependencies

RUN /usr/local/bin/tools/agree-to-licenses.sh "android update sdk --all --no-ui --filter ${SDK_PACKAGES}"
