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
## Variables
FIXTURES_FOLDER="./tests/integration/fixtures"
TEST_PACKAGE_FILE="5gtango-ns-package-example.tgo"
PRE_INTEGRATION_URL="http://pre-int-sp-ath.5gtango.eu:32002/api/v3"
PACKAGES_PRE_INTEGRATION_URL="$PRE_INTEGRATION_URL/packages"

# Test package file presence
echo "Testing package file presence..."
echo "PWD is $(pwd)"
FILES_PRESENT=$(ls)
echo "Files present: $FILES_PRESENT"

if  ! [ -e "$FIXTURES_FOLDER/$TEST_PACKAGE_FILE" ]
then
    echo "Test package file $TEST_PACKAGE_FILE not found in $FIXTURES_FOLDER folder"
    exit 1
fi
echo "    ...done!"

# Testing package file upload
echo "Testing package file upload..."
#curl -X POST $PRE_INTEGRATION -F x=1 -F y=2 -F package=@"$FIXTURES_FOLDER/$TEST_PACKAGE_FILE"
#REGISTER_RESPONSE=$(curl -qSfsw '\n%{http_code}' -d '{"username":"'$USER'","password":"'$PASSWORD'","user_type":"developer","email":"'"$USER"'@sonata-nfv.eu"}' sp.int.sonata-nfv.eu:32001/api/v2/users)
#echo "REGISTER_RESPONSE was $REGISTER_RESPONSE"
#RESP=$(curl -qSfs -d '{"username":"sonata-'$NONCE'","password":"1234"}' http://sp.int.sonata-nfv.eu:32001/api/v2/sessions)
#echo "User $USER logged in: $RESP"
#token=$(echo $RESP | jq -r '.token.access_token')

UPLOAD_RESPONSE=$(curl -qfsS -X POST $PACKAGES_PRE_INTEGRATION_URL -F package=@"$FIXTURES_FOLDER/$TEST_PACKAGE_FILE")
echo "UPLOAD_RESPONSE=$UPLOAD_RESPONSE"
PROCESS_UUID=$(echo $UPLOAD_RESPONSE | jq -r '.package_process_uuid')
echo "PROCESS_UUID=$PROCESS_UUID"
if [ -z "$PROCESS_UUID" ]; then
  echo "Package file $FIXTURES_FOLDER/$TEST_PACKAGE_FILE upload to $PACKAGES_PRE_INTEGRATION_URL failled with $UPLOAD_RESPONSE"
  exit 1
fi
echo "    ...successfuly!"
echo "Getting package status..."
PACKAGE_PROCESS_STATUS=$(curl -qfsS "$PACKAGES_PRE_INTEGRATION_URL/status/$PROCESS_UUID")
echo "PACKAGE_PROCESS_STATUS=$PACKAGE_PROCESS_STATUS"
echo "Getting package uuid..."
echo "    ...not done yet!"
echo "Getting package meta-data..."
echo "    ...not done yet!"
echo "Getting package file..."
echo "    ...not done yet!"
echo "Deleting the package..."
echo "    ...not done yet!"
echo "Verify that package has been deleted..."
echo "    ...not done yet!"
echo "    ...done!"