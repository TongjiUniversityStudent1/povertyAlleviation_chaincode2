#!/bin/bash
#
# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#

jq --version > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Please Install 'jq' https://stedolan.github.io/jq/ to execute this script"
  echo
  exit 1
fi
starttime=$(date +%s)

echo "POST request Enroll on Org1  ..."
echo
ORG1_TOKEN=$(curl -s -X POST \
  http://10.1.3.207:4000/users \
  -H "content-type: application/x-www-form-urlencoded" \
  -d 'username=Jim&orgName=org1')
echo $ORG1_TOKEN
ORG1_TOKEN=$(echo $ORG1_TOKEN | jq ".token" | sed "s/\"//g")
echo
echo "ORG1 token is $ORG1_TOKEN"
echo
# echo "POST request Enroll on Org2 ..."
# echo
# ORG2_TOKEN=$(curl -s -X POST \
#   http://10.1.3.207:4000/users \
#   -H "content-type: application/x-www-form-urlencoded" \
#   -d 'username=Barry&orgName=org2')
# echo $ORG2_TOKEN
# ORG2_TOKEN=$(echo $ORG2_TOKEN | jq ".token" | sed "s/\"//g")
# echo
# echo "ORG2 token is $ORG2_TOKEN"
# echo
echo
echo "POST request Create channel  ..."
echo
curl -s -X POST \
  http://10.1.3.207:4000/channels \
  -H "authorization: Bearer $ORG1_TOKEN" \
  -H "content-type: application/json" \
  -d '{
  "channelName":"mychannel",
  "channelConfigPath":"../artifacts/channel/mychannel.tx"
}'
echo
echo
sleep 5
echo "POST request Join channel on Org1"
echo
curl -s -X POST \
  http://10.1.3.207:4000/channels/mychannel/peers \
  -H "authorization: Bearer $ORG1_TOKEN" \
  -H "content-type: application/json" \
  -d '{
  "peers": ["10.1.3.207:7051","10.1.3.207:7056"]
}'
echo
echo


echo "POST Install charity on Org1"
echo
curl -s -X POST \
  http://10.1.3.207:4000/chaincodes \
  -H "authorization: Bearer $ORG1_TOKEN" \
  -H "content-type: application/json" \
  -d '{
  "peers": ["10.1.3.207:7051","10.1.3.207:7056"],
  "chaincodeName":"charity",
  "chaincodePath":"github.com/charity",
  "chaincodeVersion":"v0"
}'
echo
echo


echo "POST instantiate charity on peer1 of Org1"
echo
curl -s -X POST \
  http://10.1.3.207:4000/channels/mychannel/chaincodes \
  -H "authorization: Bearer $ORG1_TOKEN" \
  -H "content-type: application/json" \
  -d '{
  "peers": ["10.1.3.207:7051"],
  "chaincodeName":"charity",
  "chaincodeVersion":"v0",
  "functionName":"init",
  "args":[]
}'
echo
echo

echo "POST instantiate charity on peer1 of Org1"
echo
curl -s -X POST \
  http://10.1.3.207:4000/channels/mychannel/chaincodes \
  -H "authorization: Bearer $ORG1_TOKEN" \
  -H "content-type: application/json" \
  -d '{
  "peers": ["10.1.3.207:7051"],
  "chaincodeName":"charity",
  "chaincodeVersion":"v0",
  "functionName":"init",
  "args":[]
}'
echo
echo