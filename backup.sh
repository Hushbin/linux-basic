otkuda="/app/"

kuda="/mnt/backup"

# Указываем,какие папки хотим забэкапить, есои нужна не одна.

which_dir="dir1 dir2 dir3 dir4 dir5"

# Создаем папку с датой в названии под наш бэкап.

mkdir -p $kuda/$(date +"%Y-%m-%d")

backup_dir="$kuda/$(date +"%Y-%m-%d")"

# Начинаем цикл, где для каждого значения перпменной выполняем набор действий

for dir in $which_dir; do
	echo "Копируем $otkuda$dir в $backup_dir"
	
	# Копируем указанные папки рекурсивно (-a), с выводом процесса (-v) и удобочитаемыми размерами

	rsync -avh $otkuda$dir $backup_dir

done

# Архивируем папку с бэкапом
# c – создает новый файл .tar;
# v – выводит подробное описание процесса сжатия;
# f – имя файла.
# z - сжатие gzip, чтобы уменьшить размер архива. 

tar -cvzf /root/Yandex.Disk/backup_$(date +"%Y-%m-%d").tar.gz $backup_dir

# Удаляем архивированные файлы для экономии места

rm -rf $backup_dir

# Перезапуск Яндекс.Диска

yandex-disk stop
yandex-disk start
