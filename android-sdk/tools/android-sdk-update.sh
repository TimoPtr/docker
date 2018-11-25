#!/bin/bash

mkdir -p /opt/android-home/android-sdk-linux/bin/
cp /opt/android-home/tools/android-env.sh /opt/android-home/android-sdk-linux/bin/
source /opt/android-home/android-sdk-linux/bin/android-env.sh

built_in_sdk=1

if [ $# -ge 0 ] && [ "$1" == "lazy-dl" ]
then
    echo "Using Lazy Download Flavour"
    built_in_sdk=0
elif [ $# -ge 0 ] && [ "$1" == "built-in" ]
then
    echo "Using Built-In SDK Flavour"
    built_in_sdk=1
else
    echo "Please use either built-in or lazy-dl as parameter"
    exit 1
fi

cd ${ANDROID_HOME}
echo "Set ANDROID_HOME to ${ANDROID_HOME}"

if [ -f sdk-tools-linux.zip ]
then
  echo "SDK Tools already bootstrapped. Skipping initial setup"
else
  echo "Bootstrapping SDK-Tools"
  wget -q https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -O sdk-tools-linux.zip
  unzip sdk-tools-linux.zip
  rm -rf sdk-tools-linux.zip
fi

echo "Make sure repositories.cfg exists"
mkdir -p ${ANDROID_HOME}/.android/
touch ${ANDROID_HOME}/.android/repositories.cfg

echo "Copying Licences"
cp -rv /opt/android-home/licenses ${ANDROID_HOME}/licenses

echo "Copying Tools"
mkdir -p ${ANDROID_HOME}/bin
cp -v /opt/android-home/tools/*.sh ${ANDROID_HOME}/bin

echo "Installing packages"
if [ $built_in_sdk -eq 1 ]
then
    # This one is use to build the docker image
    #android-accept-licenses.sh "sdkmanager ${SDKMNGR_OPTS} --package_file=/opt/android-home/tools/package-list-minimal.txt --verbose"
    android-accept-licenses.sh "sdkmanager ${SDKMNGR_OPTS} \"build-tools;28.0.2\" \"build-tools;27.0.3\" \"build-tools;27.0.2\" \"build-tools;27.0.1\" \"extras;android;m2repository\" \"extras;google;m2repository\" \"platforms;android-27\" \"platforms;android-28\" \"tools\" \"cmake;3.6.4111459\" \"ndk-bundle\" \"platform-tools\" --verbose"
else
    android-accept-licenses.sh "sdkmanager ${SDKMNGR_OPTS} --package_file=/opt/android-home/tools/package-list.txt --verbose"
fi

echo "Updating SDK"
update_sdk

echo "Accepting Licenses"
android-accept-licenses.sh "sdkmanager ${SDKMNGR_OPTS} --licenses --verbose"
