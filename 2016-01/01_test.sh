#!/usr/bin/env bash
USAGE=" 01_test.sh app_id app_secret
"
function error_null(){
    echo "ERROR : $1 not null"
    echo ${USAGE}
    exit 1
}

app_id=$1
app_secret=$2

if [ -z ${app_id} ]; then error_null "app_id" ; fi;
if [ -z ${app_secret} ]; then error_null "app_secret" ; fi;

get_access_token="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=$app_id&secret=$app_secret"
access_token=`curl -s ${get_access_token} | sed -e 's/[{}]//g' | awk -F : '{print $2}' | cut -d , -f 1 | sed -e 's/"//g'`
get_material_count=https://api.weixin.qq.com/cgi-bin/material/get_materialcount?access_token=$access_token
curl ${get_material_count}
