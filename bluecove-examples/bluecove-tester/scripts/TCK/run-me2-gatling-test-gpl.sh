#!/bin/sh
# @version $Revision$ ($Author$) $Date$
#
. ./tck-environment.sh
if [ ! "$?" = "0" ]; then
    echo Error calling tck-environment.sh
    exit 1
fi

if [ ! -d "${MICROEMULATOR_HOME}" ] ; then
  echo "Invalid Microemulator directory ${MICROEMULATOR_HOME}"
  exit 1
fi

if [ ! -f "${MICROEMULATOR_HOME}/microemulator.jar" ] ; then
  echo "Microemulator jar not found in directory ${MICROEMULATOR_HOME}"
  exit 1
fi

if [ ! -f "${BLUECOVE_GPL_JAR}" ] ; then
  echo "BlueCove-GPL not found ${BLUECOVE_GPL_JAR}"
  exit 1
fi

BLUECOVE_TCK_CP="${MICROEMULATOR_HOME}/microemulator.jar"
BLUECOVE_TCK_CP="${BLUECOVE_TCK_CP}:${BLUECOVE_JAR}:${BLUECOVE_GPL_JAR}"

JVM_ARGS=$*
#JVM_ARGS="${JVM_ARGS} -Dbluecove.debug=1"

java -cp "${BLUECOVE_TCK_CP}" ${JVM_ARGS} ${MICROEMULATOR_MAIN} ${MICROEMULATOR_ARGS} -Xautotest:http://${BLUECOVE_TCK_HOST}:${BLUECOVE_TCK_PORT}/getNextApp.jad | tee tck_test-gpl.log
rc=$?
if [ ! "${rc}" = "0" ]; then
    echo Error calling java
    echo Prsess enter to exit
    read
fi
