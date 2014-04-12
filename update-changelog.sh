#!/bin/bash

BASENAME=`basename $0`

if [ $# -ne 1 ]
then
	echo "usage: ${BASENAME} git-repo"
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

VERSION=`grep -w id ${PARENTDIR}/${ADDON}/addon.xml | cut -d\" -f6`
CHANGELOG=${PARENTDIR}/${ADDON}/changelog.txt
GITCHANGES=`cd ${PARENTDIR}/${ADDON};git log --no-merges --format="%s [%h]" master..develop`
OLDCHANGELOG=`cat ${PARENTDIR}/${ADDON}/changelog.txt`

echo "*** $VERSION ***" > ${CHANGELOG}
echo "${GITCHANGES}" >> ${CHANGELOG}
echo >> ${CHANGELOG}
echo "${OLDCHANGELOG}" >> ${CHANGELOG}
cd ${PARENTDIR}/${ADDON}
git diff changelog.txt
