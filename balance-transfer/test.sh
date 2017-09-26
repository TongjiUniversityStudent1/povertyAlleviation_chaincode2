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
  http://localhost:4000/users \
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
#   http://localhost:4000/users \
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
  http://localhost:4000/channels \
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
  http://localhost:4000/channels/mychannel/peers \
  -H "authorization: Bearer $ORG1_TOKEN" \
  -H "content-type: application/json" \
  -d '{
  "peers": ["localhost:7051","localhost:7056"]
}'
echo
echo


echo "POST Install chariB on Org1"
echo
curl -s -X POST \
  http://localhost:4000/chaincodes \
  -H "authorization: Bearer $ORG1_TOKEN" \
  -H "content-type: application/json" \
  -d '{
  "peers": ["localhost:7051","localhost:7056"],
  "chaincodeName":"chariB",
  "chaincodePath":"github.com/test",
  "chaincodeVersion":"v0"
}'
echo
echo

echo "POST Install publicityList1 on Org1"
echo
curl -s -X POST \
  http://localhost:4000/chaincodes \
  -H "authorization: Bearer $ORG1_TOKEN" \
  -H "content-type: application/json" \
  -d '{
  "peers": ["localhost:7051","localhost:7056"],
  "chaincodeName":"publicityList1",
  "chaincodePath":"github.com/mytest",
  "chaincodeVersion":"v0"
}'
echo
echo

echo "POST Install publicityReport1 on Org1"
echo
curl -s -X POST \
  http://localhost:4000/chaincodes \
  -H "authorization: Bearer $ORG1_TOKEN" \
  -H "content-type: application/json" \
  -d '{
  "peers": ["localhost:7051","localhost:7056"],
  "chaincodeName":"publicityReport1",
  "chaincodePath":"github.com/publicReport",
  "chaincodeVersion":"v0"
}'
echo
echo

echo "POST Install fundRaise on Org1"
echo
curl -s -X POST \
  http://localhost:4000/chaincodes \
  -H "authorization: Bearer $ORG1_TOKEN" \
  -H "content-type: application/json" \
  -d '{
  "peers": ["localhost:7051","localhost:7056"],
  "chaincodeName":"fundRaise",
  "chaincodePath":"github.com/fundRaise",
  "chaincodeVersion":"v0"
}'
echo
echo

echo "POST Install projectLibrary on Org1"
echo
curl -s -X POST \
  http://localhost:4000/chaincodes \
  -H "authorization: Bearer $ORG1_TOKEN" \
  -H "content-type: application/json" \
  -d '{
  "peers": ["localhost:7051","localhost:7056"],
  "chaincodeName":"projectLibrary",
  "chaincodePath":"github.com/projectLibrary",
  "chaincodeVersion":"v0"
}'
echo
echo

# echo "POST Install project on Org1"
# echo
# curl -s -X POST \
#   http://localhost:4000/chaincodes \
#   -H "authorization: Bearer $ORG1_TOKEN" \
#   -H "content-type: application/json" \
#   -d '{
#   "peers": ["localhost:7051","localhost:7056"],
#   "chaincodeName":"project",
#   "chaincodePath":"github.com/project",
#   "chaincodeVersion":"v0"
# }'
# echo
# echo

echo "POST instantiate chariB on peer1 of Org1"
echo
curl -s -X POST \
  http://localhost:4000/channels/mychannel/chaincodes \
  -H "authorization: Bearer $ORG1_TOKEN" \
  -H "content-type: application/json" \
  -d '{
  "peers": ["localhost:7051"],
  "chaincodeName":"chariB",
  "chaincodeVersion":"v0",
  "functionName":"init",
  "args":[]
}'
echo
echo
echo "POST instantiate chariB on peer1 of Org1"
echo
curl -s -X POST \
  http://localhost:4000/channels/mychannel/chaincodes \
  -H "authorization: Bearer $ORG1_TOKEN" \
  -H "content-type: application/json" \
  -d '{
  "peers": ["localhost:7051"],
  "chaincodeName":"chariB",
  "chaincodeVersion":"v0",
  "functionName":"init",
  "args":[]
}'
echo
echo

echo "POST instantiate publicityList1 on peer1 of Org1"
echo
curl -s -X POST \
  http://localhost:4000/channels/mychannel/chaincodes \
  -H "authorization: Bearer $ORG1_TOKEN" \
  -H "content-type: application/json" \
  -d '{
  "peers": ["localhost:7051"],
  "chaincodeName":"publicityList1",
  "chaincodeVersion":"v0",
  "functionName":"init",
  "args":["2017","6789"]
}'
echo
echo
echo "POST instantiate publicityList1 on peer1 of Org1"
echo
curl -s -X POST \
  http://localhost:4000/channels/mychannel/chaincodes \
  -H "authorization: Bearer $ORG1_TOKEN" \
  -H "content-type: application/json" \
  -d '{
  "peers": ["localhost:7051"],
  "chaincodeName":"publicityList1",
  "chaincodeVersion":"v0",
  "functionName":"init",
  "args":["2017","6789"]
}'
echo
echo

echo "POST instantiate publicityReport1 on peer1 of Org1"
echo
curl -s -X POST \
  http://localhost:4000/channels/mychannel/chaincodes \
  -H "authorization: Bearer $ORG1_TOKEN" \
  -H "content-type: application/json" \
  -d '{
  "peers": ["localhost:7051"],
  "chaincodeName":"publicityReport1",
  "chaincodeVersion":"v0",
  "functionName":"init",
  "args":["2017","6789"]
}'
echo
echo
echo "POST instantiate publicityReport1 on peer1 of Org1"
echo
curl -s -X POST \
  http://localhost:4000/channels/mychannel/chaincodes \
  -H "authorization: Bearer $ORG1_TOKEN" \
  -H "content-type: application/json" \
  -d '{
  "peers": ["localhost:7051"],
  "chaincodeName":"publicityReport1",
  "chaincodeVersion":"v0",
  "functionName":"init",
  "args":["2017","6789"]
}'
echo
echo
echo "POST instantiate projectLibrary on peer1 of Org1"
echo
curl -s -X POST \
  http://localhost:4000/channels/mychannel/chaincodes \
  -H "authorization: Bearer $ORG1_TOKEN" \
  -H "content-type: application/json" \
  -d '{
  "peers": ["localhost:7051"],
  "chaincodeName":"projectLibrary",
  "chaincodeVersion":"v0",
  "functionName":"init",
  "args":[]
}'
echo
echo
echo "POST instantiate projectLibrary on peer1 of Org1"
echo
curl -s -X POST \
  http://localhost:4000/channels/mychannel/chaincodes \
  -H "authorization: Bearer $ORG1_TOKEN" \
  -H "content-type: application/json" \
  -d '{
  "peers": ["localhost:7051"],
  "chaincodeName":"projectLibrary",
  "chaincodeVersion":"v0",
  "functionName":"init",
  "args":[]
}'
echo
echo

echo "POST instantiate fundRaise on peer1 of Org1"
echo
curl -s -X POST \
  http://localhost:4000/channels/mychannel/chaincodes \
  -H "authorization: Bearer $ORG1_TOKEN" \
  -H "content-type: application/json" \
  -d '{
  "peers": ["localhost:7051"],
  "chaincodeName":"fundRaise",
  "chaincodeVersion":"v0",
  "functionName":"init",
  "args":[]
}'
echo
echo
echo "POST instantiate fundRaise on peer1 of Org1"
echo
curl -s -X POST \
  http://localhost:4000/channels/mychannel/chaincodes \
  -H "authorization: Bearer $ORG1_TOKEN" \
  -H "content-type: application/json" \
  -d '{
  "peers": ["localhost:7051"],
  "chaincodeName":"fundRaise",
  "chaincodeVersion":"v0",
  "functionName":"init",
  "args":[]
}'
echo
echo
# echo "POST instantiate project on peer1 of Org1"
# echo
# curl -s -X POST \
#   http://localhost:4000/channels/mychannel/chaincodes \
#   -H "authorization: Bearer $ORG1_TOKEN" \
#   -H "content-type: application/json" \
#   -d '{
#   "peers": ["localhost:7051"],
#   "chaincodeName":"project",
#   "chaincodeVersion":"v0",
#   "functionName":"init",
#   "args":[]
# }'
# echo
# echo