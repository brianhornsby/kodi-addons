#!/bin/bash

BASENAME=`basename $0`

if [ $# -ne 3 ]
then
	echo "usage: ${BASENAME} addon-directory username password"
	exit 1
fi

ADDON_ID=`basename $1`
PARENTDIR=`dirname $1`
USERNAME=$2
PASSWORD=$3
BRANCH=`cd ${PARENTDIR}/${ADDON_ID};git rev-parse --abbrev-ref HEAD`
if [ "${BRANCH}" != "master" ]
then
	echo "${BASENAME}: ERROR: Git branch is not set to master"
	exit 1
fi
ADDONXML=${PARENTDIR}/${ADDON_ID}/addon.xml

ADDON_VERSION=`grep -w id ${ADDONXML} | cut -d\" -f6`
ADDON_NAME=`grep -w name ${ADDONXML} | cut -d\" -f4`
${PARENTDIR}/create-release.py ${USERNAME} ${PASSWORD} ${ADDON_ID} ${ADDON_NAME} ${ADDON_VERSION}
