# Переменные для выделения цветом вывода скрипта в echo 
green='\e[32m'
blue='\e[34m'
bgblue='\033[44m'
white='\033[1;37m'
clear='\e[0m'
 
# Функции для цветного вывода
ColorGreen(){
    echo -ne $green$1$clear
}
ColorBlue(){
    echo -ne $blue$1$clear
}
BackgroundBlue(){
    echo -ne $bgblue$white$1$clear # без white текст выглядит блекло
}

server_name=$(hostname)

server_ip=$(wget -O - -q icanhazip.com)



#### Function for checking open ports

open_ports(){

BackgroundBlue '==================== Cписок открытых портов ss -lupnt ==================== \n'
echo "" # добавляем пустую строку для красоты

ss -tulpn # Открытые порты

echo "" # добавляем пустую строку для красоты
BackgroundBlue '-------------------------------------------------------------------------- \n'
}



#### Function for checking avarage load

load_average(){
 line=$(uptime) # Записываем результат команды в строку

BackgroundBlue '========== LOAD AVERAGE ==========  \n'
echo ${line#*users,} # Выводим все, что идет после 'users,'

# Полный вывод команды выглядит так: 19:35:42 up 4 days, 12:15,  2 users,  load average: 0,00, 0,00, 0,00

BackgroundBlue '------------------------------------ \n'
}



#### Function for checking memory load

mem_free(){
 
BackgroundBlue '==================== Статус оперативной памяти ==================== \n'
echo "" # добавляем пустую строку для красоты
 
free -h 
 
echo "" # добавляем пустую строку для красоты
BackgroundBlue '-------------------------------------------------------------------------- \n'
}



#### Function for checking kernel version

kernel_os_version(){

BackgroundBlue '==================== Информация о версии ядра и ОС ==================== \n'
echo "" # добавляем пустую строку для красоты

echo $(cat /etc/os-release | grep PRETTY_NAME | awk -F"=" '{ print $2 }') # Версия ОС
uname -r  # Версия ядра Linux

echo "" # добавляем пустую строку для красоты
BackgroundBlue '-------------------------------------------------------------------------- \n'
}


#### Function for checking all at the same time

all_check(){
	kernel_os_version
	mem_free
	load_average
	open_ports
}


#### Function for Menu

menu(){
echo -ne "
$(BackgroundBlue ' Сервер ')
$(BackgroundBlue " $server_ip $server_name ")
$(ColorGreen '1)') Открытые порты
$(ColorGreen '2)') Нагрузка на сервер
$(ColorGreen '3)') ОЗУ
$(ColorGreen '4)') Версия ядра
$(ColorGreen '5)') Check All
$(ColorGreen '0)') Выход
"

read a
case $a in
            1) open_ports ; menu ;;
            2) load_average ; menu ;;
            3) mem_free ; menu ;;
            4) kernel_os_version ; menu ;;
            5) all_check ; menu ;;
        0) exit 0 ;;
        *) echo "Неверная опция"; WrongCommand;;
esac
}

menu # First menu call

