#!/bin/bash
set -e

thisDir=$(pwd)
export WORK_DIR=$thisDir/work
export MICROWALK_DIR=$thisDir/Microwalk
export PIN_ROOT=$(realpath $thisDir/../pin/pin)

mkdir -p $WORK_DIR

for target in $(find . -name "target-rsa-test.c" -print)
do
    targetName=$(basename -- ${target%.*})

    echo "Running target ${targetName}..."

    export TESTCASE_DIRECTORY=$thisDir/testcases
    export TARGET_NAME=$targetName

    mkdir -p $WORK_DIR/$targetName/work
    mkdir -p $WORK_DIR/$targetName/persist

    time dotnet Microwalk/Microwalk/bin/Release/net8.0/Microwalk.dll $thisDir/config.yml -p Microwalk/Microwalk.Plugins.PinTracer/bin/Release/net8.0

    echo "Running target ${targetName} successful"
done
