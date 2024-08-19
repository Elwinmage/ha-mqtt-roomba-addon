#!/usr/bin/with-contenv bashio

echo 'Star Roomba MQTT server'
echo '***********************'
echo `date`
echo '-----------------------'


CONFIG_PATH=/data/options.json

Roomba_UID="$(bashio::config 'Roomba_UID')"
Roomba_Password="$(bashio::config 'Roomba_Password')"
Roomba_IP="$(bashio::config 'Roomba_IP')"
MQTT_IP="$(bashio::config 'MQTT_IP')"
MQTT_PORT="$(bashio::config 'MQTT_PORT')"
MQTT_USER="$(bashio::config 'MQTT_USER')"
MQTT_PASSWORD="$(bashio::config 'MQTT_PASSWORD')"

ACCOUNT_LOGIN="$(bashio::config 'ACCOUNT_LOGIN')"
ACCOUNT_PASSWORD="$(bashio::config 'ACCOUNT_PASSWORD')"

TOPIC="/roomba/rooms"

OLD_IFS=${IFS}
ROOMS="["
export IFS="
"



for room in `IRBT_LOGIN=${ACCOUNT_LOGIN} IRBT_PASSWORD=${ACCOUNT_PASSWORD} irbt-cli.py -l`
do
    name=`echo $room|cut -d ':' -f 1`
    id=`echo $room|cut -d ':' -f 2|sed s/' '/''/g`
    ROOMS="${ROOMS}{\"name\": \"$name\",\"id\": $id},"
done
ROOMS="${ROOMS::-1}]"
IFS=${OLD_IFS}

mosquitto_pub -r -h ${MQTT_IP} -p ${MQTT_PORT} -u ${MQTT_USER} -P "${MQTT_PASSWORD}" -t ${TOPIC} -m "${ROOMS}"

/opt/app/Roomba980-Python/roomba/roomba.py -u ${Roomba_UID} -w "${Roomba_Password}" -R ${Roomba_IP} -b ${MQTT_IP} -p ${MQTT_PORT} -U ${MQTT_USER} -P "${MQTT_PASSWORD}" 
