#!/usr/bin/env bash
app_id=
app_secret=

USAGE="Usage : 01_test.sh [parameters]
    The available parameters:
        -f <secret_file>                      # use secret_file directly
        --app_id=<id> --app_secret=<secret>   # privde id and secret from command line
"
function error(){
    echo "ERROR : $@"
    echo "$USAGE"
    exit 1
}

while (( "$#" )); do
    case $1 in
        -f)
            shift;
            secret_file=$1
            if [ -e ${secret_file} ];then
                source ${secret_file}
            else
                error "secrect file $secret_file not found."
            fi
            break;;
        --app_id=*)
            app_id=`echo $1|sed -e 's/--app_id=//'`
            shift;;
        --app_secret=*)
            app_secret=`echo $1|sed -e 's/--app_secret=//'`
            shift;;
        *)
            error "unknown paramerter $1"
    esac
done

if [ -z ${app_id} ]; then error "input app_id" ; fi;
if [ -z ${app_secret} ]; then error "input app_secret" ; fi;

echo "DEBUG: app_id=$app_id"
echo "DEBUG: app_secret=$app_secret"

get_access_token="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=$app_id&secret=$app_secret"
access_token=`curl -s ${get_access_token} | sed -e 's/[{}]//g' | awk -F : '{print $2}' | cut -d , -f 1 | sed -e 's/"//g'`
get_material_count=https://api.weixin.qq.com/cgi-bin/material/get_materialcount?access_token=${access_token}
curl ${get_material_count}
echo
