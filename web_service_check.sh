#!/bin/bash

# Возвращение вывода к стандартному форматированию
NORMAL='\033[0m'      # ${NORMAL}

# Цветом текста (жирным) (bold) :
WHITE='\033[1;37m'    # ${WHITE}

# Цвет фона
BGRED='\033[41m'      # ${BGRED}
BGGREEN='\033[42m'    # ${BGGREEN}
BGBLUE='\033[44m'     # ${BGBLUE}


tg="/home/hushbin/bash_scrypting_yodo/telegram.sh"
# Получаем статус веб-сервера через systemd, записываем его в переменную.
nginxstatus=$(systemctl status nginx | grep -Eo "running|dead|failed")

if [[ $nginxstatus = 'running' ]]

  then
    echo -en  "${WHITE} ${BGGREEN} Веб сервер работает ${NORMAL}\n"

  else
    $tg "Nginx не работает, пробуем перезапустить..." > /dev/null
    sudo systemctl start nginx # Перезапуск nginx
    sleep 2 # Ожидаем 2 секунды, чтобы сервер точно запустился
    $tg "Статус Nginx после перезапуска $(systemctl status nginx | grep -Eo "running|dead|failed") !!" > /dev/null

fi

# Получаем статус php чрез systemd, записываем его в переменную.
phpfpmstatus=$(systemctl status php7.2-fpm | grep -Eo "running|dead|failed")

if [[ $phpfpmstatus = 'running' ]]

  then
    echo -en  "${WHITE} ${BGGREEN} php7.2-fpm работает ${NORMAL}\n"

  else
    $tg "Статус php7.2-fpm $phpfpmstatus! Пробуем перезапустить..." > /dev/null
    sudo systemctl start php7.2-fpm # Перезапуск php7.2-fpm
    sleep 2 # Ожидаем 2 секунды, чтобы php7.2-fpm точно запустился
    $tg "Статус php7.2-fpm после перезапуска $(systemctl status php7.2-fpm | grep -Eo "running|dead|failed") !!" > /dev/null

fi
