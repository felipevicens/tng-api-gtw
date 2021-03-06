#!/bin/bash
## Copyright (c) 2015 SONATA-NFV, 2017 5GTANGO [, ANY ADDITIONAL AFFILIATION]
## ALL RIGHTS RESERVED.
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##
## Neither the name of the SONATA-NFV, 5GTANGO [, ANY ADDITIONAL AFFILIATION]
## nor the names of its contributors may be used to endorse or promote
## products derived from this software without specific prior written
## permission.
##
## This work has been performed in the framework of the SONATA project,
## funded by the European Commission under Grant number 671517 through
## the Horizon 2020 and 5G-PPP programmes. The authors would like to
## acknowledge the contributions of their colleagues of the SONATA
## partner consortium (www.sonata-nfv.eu).
##
## This work has been performed in the framework of the 5GTANGO project,
## funded by the European Commission under Grant number 761493 through
## the Horizon 2020 and 5G-PPP programmes. The authors would like to
## acknowledge the contributions of their colleagues of the 5GTANGO
## partner consortium (www.5gtango.eu).
# encoding: utf-8
#
# This file holds the integration tests
echo "Getting package meta-data..."
PACKAGE_META_DATA_CODE=$(curl --write-out %{http_code} --silent --output /dev/null "$PACKAGES_PRE_INTEGRATION_URL/$PACKAGE_UUID")
echo "    PACKAGE_META_DATA_CODE=$PACKAGE_META_DATA_CODE"
if [ "$PACKAGE_META_DATA_CODE" != "200" ]; then
  echo "Package file $FIXTURES_FOLDER/$TEST_PACKAGE_FILE meta-data download failled with code $PACKAGE_META_DATA_CODE"
  exit 1
fi
echo "Getting the package file..."
PACKAGE_FILE_DATA=$(curl -s "$PACKAGES_PRE_INTEGRATION_URL/$PACKAGE_UUID")
PACKAGE_FILE_UUID=$(echo $PACKAGE_FILE_DATA | jq -r '.pd.package_file_uuid')
PACKAGE_FILE_NAME=$(echo $PACKAGE_FILE_DATA | jq -r '.pd.package_file_name')
echo "    There's a file named '$PACKAGE_FILE_NAME' (UUID $PACKAGE_FILE_UUID)"
echo "    Calling $PACKAGES_PRE_INTEGRATION_URL/$PACKAGE_UUID/package-file"
# pre-int-sp-ath.5gtango.eu:4011/api/catalogues/v2/tgo-packages/252c229a-e7ba-49dc-9e0a-2d200b8bb28b content-type:application/zip
PACKAGE_FILE=$(curl -s "$PACKAGES_PRE_INTEGRATION_URL/$PACKAGE_UUID/package-file")
#echo "    PACKAGE_FILE=$PACKAGE_FILE"
COMPARED_FILES=$(diff "$FIXTURES_FOLDER/$TEST_PACKAGE_FILE" $PACKAGE_FILE)
echo "    COMPARED_FILES=$COMPARED_FILES"
echo "    ...SUCCESS downloading package!"
