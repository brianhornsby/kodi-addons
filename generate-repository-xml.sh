#/bin/bash

BASENAME=`basename $0`

python ./addons_xml_generator.py
if [[ $? != 0 ]]; then
	echo "${BASENAME}: ERROR: addons_xml_generator failed"
	exit 1
fi

REPOSITORY=`find . -name "repository.*" | grep -v xml | xargs basename`

if [[ ! -d ${REPOSITORY} ]]; then
	echo "${BASENAME}: ERROR: ${REPOSITORY} does not exist"
	exit 1
fi

if [[ ! -f addons.xml ]]; then
	echo "${BASENAME}: ERROR: addon.xml does not exist"
	exit 1
fi
echo "Moving addons.xml to ${REPOSITORY}"
mv addons.xml ${REPOSITORY}/repository.xml

if [[ ! -f addons.xml.md5 ]]; then
	echo "${BASENAME}: ERROR: addon.xml.md5 does not exist"
	exit 1
fi

echo "Moving addons.xml.md5 to ${REPOSITORY}"
mv addons.xml.md5 ${REPOSITORY}/repository.xml.md5
