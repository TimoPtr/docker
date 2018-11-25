FROM debian-jdk:latest

ENV ANDROID_SDK_HOME /opt/android-home/android-sdk-linux
ENV ANDROID_SDK_ROOT /opt/android-home/android-sdk-linux
ENV ANDROID_HOME /opt/android-home/android-sdk-linux
ENV ANDROID_SDK /opt/android-home/android-sdk-linux

ENV PATH $PATH:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/bin

RUN apt-get update && apt-get install -y \
  libc6-i386 lib32gcc1 lib32ncurses5 lib32z1 \
  ca-certificates \
  curl \
  zip \
  expect \
  unzip \
  wget \
  && rm -rf /var/cache/apt/* \
  && rm -rf /tmp/*


# Create android User match to jenkins user
RUN mkdir -p /opt/android-home \
  && addgroup android --gid 111 \
  && adduser --ingroup android --home /opt/android-home --uid 106 --disabled-password --gecos '' android \
  && chown android:android /opt/android-home

# Create the folder for the sdk
RUN mkdir -p /opt/android-home/android-sdk-linux

# Create android User
RUN mkdir -p /opt/android-home/android-workdir

# Copy Tools
COPY tools /opt/android-home/tools

# Copy Licenses
COPY licenses /opt/android-home/licenses

# Working Directory
WORKDIR /opt/android-home/android-sdk-linux

RUN /opt/android-home/tools/entrypoint.sh built-in &&  chown -R android:android /opt/android-home && chmod -R 777 /opt/android-home

USER android

# Create cache directory for gradle
RUN mkdir -p /opt/android-home/.m2 && mkdir -p /opt/android-home/.gradle/caches/modules-2/files-2.1

WORKDIR /opt/android-home/android-workdir

