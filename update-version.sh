#!/bin/bash

BASENAME=`basename $0`

if [ $# -ne 1 ]
then
	echo "usage: ${BASENAME} addon-directory"
	exit 1
fi

ADDON=`basename $1`
PARENTDIR=`dirname $1`
BRANCH=`cd ${PARENTDIR}/${ADDON};git rev-parse --abbrev-ref HEAD`
if [ "${BRANCH}" != "develop" ]
then
	echo "${BASENAME}: ERROR: Git branch is not set to develop"
	exit 1
fi
ADDONXML=${PARENTDIR}/${ADDON}/addon.xml

VERSION=`grep -w id ${ADDONXML} | cut -d\" -f6`
MAJORVERSION=`echo ${VERSION} | cut -d\. -f1`
MINORVERSION=`echo ${VERSION} | cut -d\. -f2`
PATCHVERSION=`echo ${VERSION} | cut -d\. -f3`
NEWPATCHVERSION=$((PATCHVERSION+1))
NEWVERSION=${MAJORVERSION}.${MINORVERSION}.${NEWPATCHVERSION}

NEWADDONXML=`sed "s/${VERSION}/${NEWVERSION}/" ${ADDONXML}`
echo "${NEWADDONXML}" > ${ADDONXML}
cd ${PARENTDIR}/${ADDON}
git diff addon.xml
