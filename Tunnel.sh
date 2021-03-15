#!/bin/bash

service postgresql start
echo
service apache2 start
echo
clear
echo "Payload IP'nizi Giriniz :"
read payload_ip
echo
sleep 1
echo "Tünel Başlatılıyor..."
sleep 2
ngrok http $payload_ip

