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
if [ "${BRANCH}" != "master" ]
then
	echo "${BASENAME}: ERROR: Git branch is not set to master"
	exit 1
fi

VERSION=`grep -w id ${PARENTDIR}/${ADDON}/addon.xml | cut -d\" -f6`
EXCLUDE="*.pyo *.pyc *.DS_Store* *.git/* *.gitignore *.svn/* *.lwp */sftp-config.json"
REPOSITORY=`find . -name "repository.*" | grep -v xml | xargs basename`
ZIPDIR=${REPOSITORY}/releases
ADDONZIP=${PARENTDIR}/${ZIPDIR}/${ADDON}-${VERSION}.zip
if [ ! -d ${PARENTDIR}/${ZIPDIR} ]
then
	echo "${BASENAME}: ERROR: ${ZIPDIR} directory does not exist"
	exit 1
fi

if [ -e ${ADDONZIP} ]
then
	rm ${ADDONZIP}
fi

cd ${PARENTDIR}
zip -r ${ADDONZIP} ${ADDON} -x ${EXCLUDE}
echo "Archive ${ADDONZIP} created"
