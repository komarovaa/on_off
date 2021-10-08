#Забираем имя пользователя залогиненго на компе в формате Домен\имя пользователя
#$User = (Get-WMIObject -Class Win32_ComputerSystem | Select-Object username).username
#или только пользователя
$User = get-content env:\username 
$Domain_name = (Get-WMIObject -Class Win32_ComputerSystem | Select-Object domain).domain 
$Domain = $Domain_name.split(".") 
$Domen = $Domain[0] 
#New-Item -Path \\server-f\domainuser$\on_off\$Domen -ItemType "directory"
#забираем имя компа на котром запустился скрипт
$PCname = (Get-WMIObject -Class Win32_ComputerSystem | Select-Object Name).Name
#Объявляем переменные и присваиваем значения, которые будем брать из операционной системы 
$date = get-date -format "dd MMMM yyyy HH:mm:ss" 
$Booted = Get-WmiObject -Class Win32_OperatingSystem 
#$Booted = Get-CimInstance -ClassName win32_OperatingSystem | select lastbootuptime
$uptime = [DateTime]::Now - $Booted.ConvertToDateTime($Booted.LastBootUpTime) 
$TimeOn = $Booted.ConvertToDateTime($Booted.LastBootUpTime)
$RTimeON_day = ($TimeOn).day 
$RTimeON_month = ($TimeOn).month 
$RTimeON_year = ($TimeOn).year
$TimeOn_rus = $RTimeON_day + ' ' + $RTimeON_month + ' ' + $RTimeON_year 
$days = ($uptime).days 
$Hours = ($uptime).hours 
$Minutes = ($uptime).Minutes 
$Seconds = ($uptime).Seconds 
$var1 = "Время работы ПК" 
$var2 = "Время включения ПК" 
$var3 = "Дней" 
$var4 = "Время выключения ПК" 
#формируем данные  
#$All = $User + ' ' + $PCname + ' ' + $Domain_name + ' ' + $var2 + ' ' + $TimeOn + ' ' + $var4 + ' ' + $date + ' ' + $var1 + ' ' + $days + ' ' + $var3 + ' ' + $Hours + ':' + $Minutes + ':' + $Seconds
$All = $User + ' | ' + $PCname + ' | ' + $var2 + '  ' + $TimeOn + ' | ' + $var4 + '  ' + $date + ' | ' + $var1 + '  ' + $days + '  ' + $var3 + '  ' + $Hours + ':' + $Minutes + ':' + $Seconds 
$All >> \\fs\domainuser$\on_off\$Domen\$User"_"$PCname.txt
#описываем запись в файл имя домена_имя\пользователя\имя компа
$Domain_name = (Get-WMIObject -Class Win32_ComputerSystem | Select-Object domain).domain 
$Domain = $Domain_name.split(".") 
$Domen = $Domain[0] 
$User = (Get-WMIObject -Class Win32_ComputerSystem | Select-Object username).username 
#New-Item -Path \\server-f\domainuser$\on_off\$Domen -ItemType "directory" 
$PCname = (Get-WMIObject -Class Win32_ComputerSystem | Select-Object Name).Name 
write ($User + ' ' + $User_rus + ' ' + $PCname + ' ' + $Domain_name) » \\server-f\domainuser$\on_off\$Domen\$User"_"$PCname.txt
#дата записи 
#get-date >> \\server-f\domainuser$\on_off\$Domen\$User"_"$PCname.txt 
write "$PCname Uptime :"
#вывод таблицы 
#Days Hours Minutes Seconds
#---- ----- ------- -------
# Дни часы  минуты  секунды
$Booted = Get-WmiObject -Class Win32_OperatingSystem 
#[DateTime]::Now - $Booted.ConvertToDateTime($Booted.LastBootUpTime) | ft Days, Hours, Minutes, Seconds -AutoSize >> \\server-f\domainuser$\on_off\$Domen\$User"_"$PCname.txt
